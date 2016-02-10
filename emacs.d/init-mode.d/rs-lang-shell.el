
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package sh-script
  :defer t
  :config
  (setq sh-indentation 4)

  (add-hook 'sh-mode-hook 'flycheck-mode-on-safe)
  (add-hook 'sh-mode-hook 'rs/common-programming-modes))

(provide 'rs-lang-shell)
;;; rs-lang-shell.el ends here
