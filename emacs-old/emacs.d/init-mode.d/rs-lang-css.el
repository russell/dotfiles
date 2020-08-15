
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

;; CSS
(use-package css-mode
  :defer t
  :config
  (add-hook 'css-mode-hook 'rs/common-programming-modes))


(provide 'rs-lang-css)
;;; rs-lang-css.el ends here
