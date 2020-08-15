
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package rst-mode
  :defer t
  :config
  (add-hook 'rst-mode-hook 'rs/common-editing-modes))

(provide 'rs-lang-rst)
;;; rs-lang-rst.el ends here
