
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package make-mode
  :defer t
  :config
  (add-hook 'makefile-mode-hook 'rs/common-programming-modes))

(provide 'rs-lang-makefile)
;;; rs-lang-makefile.el ends here
