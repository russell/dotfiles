
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package make-mode
  :defer t
  :config
  (rs/add-common-programming-hooks 'makefile-mode))

(provide 'rs-lang-makefile)
;;; rs-lang-makefile.el ends here
