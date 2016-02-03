
(require 'use-package)

;;; Code:

(use-package flycheck
  :commands flycheck-mode
  :config
  (setq-default flycheck-emacs-lisp-load-path 'load-path)
  (setq flycheck-highlighting-mode 'lines)
  (setq flycheck-idle-change-delay 2)
  (setq flycheck-indication-mode 'right-fringe))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
