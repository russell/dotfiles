
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package xml-mode
  :defer t
  :config
  (add-hook 'xml-mode-hook 'flycheck-mode))

(use-package html-mode
  :defer t
  :config
  (add-hook 'html-mode-hook 'rs/common-programming-modes))


(provide 'rs-lang-xml)
;;; rs-lang-xml.el ends here
