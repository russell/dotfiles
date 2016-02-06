

;;; Code:

(eval-when-compile
  (require 'use-package))


(use-package markdown
  :defer t
  :config
  (add-hook 'markdown-mode-hook 'auto-fill-mode)
  (add-hook 'markdown-mode-hook 'flyspell-mode))

(provide 'rs-lang-markdown)
;;; rs-lang-markdown.el ends here
