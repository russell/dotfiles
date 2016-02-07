
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package rst-mode
  :defer t
  :config
  (rs/add-common-editing-hooks 'rst-mode))

(provide 'rs-lang-rst)
;;; rs-lang-rst.el ends here
