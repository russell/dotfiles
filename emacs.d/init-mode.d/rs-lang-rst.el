
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package rst-mode
  :defer t
  :config
  (add-hook 'rst-mode-hook 'artbollocks-mode)
  (add-hook 'rst-mode-hook 'enable-editing-modes))

(provide 'rs-lang-rst)
;;; rs-lang-rst.el ends here
