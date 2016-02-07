
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package sh-script
  :defer t
  :config
  (setq sh-indentation 4)

  (add-hook 'sh-mode-hook 'flycheck-mode-on-safe)
  (rs/add-common-programming-hooks 'sh-mode))

(provide 'rs-lang-shell)
;;; rs-lang-shell.el ends here
