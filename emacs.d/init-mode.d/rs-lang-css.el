

;;; Code:

(eval-when-compile
  (require 'use-package))

;; CSS
(use-package css-mode
  :defer t
  :config
  (add-hook 'css-mode-hook
            '(lambda ()
               (add-hook 'write-contents-functions
                         'delete-trailing-whitespace))))



(provide 'rs-lang-css)
;;; rs-lang-css.el ends here
