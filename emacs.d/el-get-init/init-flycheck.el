
(eval-when-compile
  (require 'use-package))

;;; Code:

(defun rs/flycheck-reload-emacs-lisp-load-path ()
  (interactive)
  (setq-default flycheck-emacs-lisp-load-path load-path))

(use-package flycheck
  :commands flycheck-mode
  :init
  (add-hook 'after-init-hook 'rs/flycheck-reload-emacs-lisp-load-path t)
  :config
  (setq flycheck-highlighting-mode 'lines)
  (setq flycheck-idle-change-delay 2)
  (setq flycheck-indication-mode 'right-fringe))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
