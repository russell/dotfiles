
;;; Code:

(eval-when-compile
  (require 'use-package)
  (require 'smartparens))

(use-package smartparens
  :defer t
  :config

  (require 'smartparens-config)

  (sp-with-modes '(markdown-mode gfm-mode rst-mode)
    (sp-local-pair "*" "*" :bind "C-*")
    (sp-local-tag "2" "**" "**")
    (sp-local-tag "s" "```scheme" "```")
    (sp-local-tag "<"  "<_>" "</_>" :transform 'sp-match-sgml-tags))

  (sp-with-modes '(html-mode sgml-mode)
    (sp-local-pair "<" ">"))

  (sp-use-paredit-bindings))

(provide 'init-smartparens)
;;; init-smartparens.el ends here
