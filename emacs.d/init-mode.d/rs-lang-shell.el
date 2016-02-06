
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package sh-script
  :defer t
  :config
  (setq sh-indentation 4)

  ;; Flycheck
  (add-hook 'sh-mode-hook 'flycheck-mode-on-safe))

(provide 'rs-lang-shell)
;;; rs-lang-shell.el ends here
