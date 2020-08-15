

;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package markdown
  :defer t
  :config
  (add-hook 'markdown-mode-hook 'rs/common-editing-modes))

(provide 'rs-lang-markdown)
;;; rs-lang-markdown.el ends here
