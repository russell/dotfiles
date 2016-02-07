
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

;; CSS
(use-package css-mode
  :defer t
  :config
  (rs/add-common-programming-hooks 'css-mode))


(provide 'rs-lang-css)
;;; rs-lang-css.el ends here
