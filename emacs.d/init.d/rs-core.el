
;;; Code:

(eval-when-compile
 (require 'use-package))

(setq user-full-name "Russell Sim")
(setq user-mail-address "russell.sim@gmail.com")

(setq confirm-kill-emacs (quote yes-or-no-p))

(setq inhibit-startup-screen t)

(use-package uniquify)
(setq uniquify-buffer-name-style 'reverse)

; title format
(setq frame-title-format "%b - emacs")

(setq message-log-max 1000)

(use-package ibuffer)

;;; Some constants to check the system type
(defconst rs/darwin-p (eq system-type 'darwin) "Are we on OSX?")
(defconst rs/linux-p (or (eq system-type 'gnu/linux)
                      (eq system-type 'linux))
  "Are we running on a GNU/Linux system?")
(defconst rs/console-p (eq (symbol-value 'window-system) nil)
  "Are we in a console?")


(defconst rs/debian-p
  "Is the current system Debian or Ubuntu."
  (let ((lsb-release (executable-find "lsb_release")))
    (when lsb-release
      (member
       (cadr
        (cdr
         (split-string
          (with-temp-buffer
            (shell-command (concat lsb-release " -i")
                           (current-buffer))
            (buffer-substring (point-min) (point-max))) "[: \f\t\n\r\v]+" t)))
       '("Debian" "Ubuntu")))))

(defconst rs/hostname
  (let ((hostname (executable-find "hostname")))
    (when hostname
      (with-temp-buffer
        (shell-command (concat hostname)
                       (current-buffer))
        (buffer-substring (point-min)
                          (save-excursion
                            (move-end-of-line nil)
                            (point))))))
  "The unqualified hostname of the computer.")

(use-package ispell
  :config
  (setq ispell-program-name "aspell")
  (setq ispell-dictionary "british"))

(use-package flyspell
  :defer t
  :config
  (setq flyspell-issue-welcome-flag nil))

(custom-set-variables
 '(custom-theme-directory "~/.emacs.d/themes/")
 '(custom-safe-themes t)
 '(custom-enabled-themes '(arrsim-custom tsdh-dark)))

(provide 'rs-core)
;;; rs-core.el ends here
