
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package xml-mode
  :defer t
  :config
  (add-hook 'xml-mode-hook 'flycheck-mode))

(use-package html-mode
  :defer t
  :config
  (add-hook 'html-mode-hook 'flyspell-mode)
  ;; diff hl mode
  (add-hook 'html-mode-hook 'turn-on-diff-hl-mode)

  ;; Delete whitespace on save.
  (add-hook 'html-mode-hook
            '(lambda ()
               (add-hook 'write-contents-functions
                         'delete-trailing-whitespace))))


(provide 'rs-lang-xml)
;;; rs-lang-xml.el ends here
