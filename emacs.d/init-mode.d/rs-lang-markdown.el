

;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package markdown
  :defer t
  :config
  (rs/add-common-editing-hooks 'markdown-mode))

(provide 'rs-lang-markdown)
;;; rs-lang-markdown.el ends here
