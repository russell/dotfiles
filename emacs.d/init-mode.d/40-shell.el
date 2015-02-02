;; Terminal color config

;;; Code:

(require 'ansi-color)
(require 'comint)
(require 'term)

(setq ansi-color-names-vector ["black" "tomato" "#8ae234" "#edd400"
			       "#729fcf" "#ad7fa8" "light cyan" "white"])
(setf ansi-color-map (ansi-color-make-color-map))

(setq term-default-bg-color "#2e3434")
(setq term-default-fg-color "#eeeeec")

;; Shell
(defun add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification
	       '(:propertize (" " term-ansi-at-dir " ") face dired-directory)))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)

(add-hook 'shell-mode-hook
          (lambda ()
            (set (make-local-variable 'comint-prompt-read-only) t)))


(defun rs/shell (&optional buffer)
  (interactive)
  (let* ((tramp-path (when (tramp-tramp-file-p default-directory)
                       (tramp-dissect-file-name default-directory)))
         (host (tramp-file-name-real-host tramp-path))
         (user (if (tramp-file-name-user tramp-path)
                 (format "%s@" (tramp-file-name-user tramp-path)) ""))
         (new-buffer-name (format "*shell:%s%s*" user host)))
    (shell (if host new-buffer-name buffer))))

;; This isn't working yet, i need to find a way to remove the old prompt.
;; (defun set-shell-ps1 ()
;;   (comint-simple-send (current-buffer) " export PS1='[\\t] \\$ '"))
;; (add-hook 'shell-mode-hook 'set-shell-ps1)


;; Term
(add-hook 'term-mode-hook (lambda ()
                            (define-key term-raw-map (kbd "C-y") 'term-paste)))
(add-hook 'term-mode-hook 'add-mode-line-dirtrack)

;;; 40-shell.el ends here
