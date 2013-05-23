;;; markdown-mode
(require 'smartparens)
(require 'smartparens-config)

(sp-with-modes '(markdown-mode gfm-mode rst-mode)
  (sp-local-pair "*" "*" :bind "C-*")
  (sp-local-tag "2" "**" "**")
  (sp-local-tag "s" "```scheme" "```")
  (sp-local-tag "<"  "<_>" "</_>" :transform 'sp-match-sgml-tags))

;;; html like modes
(sp-with-modes '(html-mode sgml-mode)
  (sp-local-pair "<" ">"))
