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

(sp-use-paredit-bindings)

;; Python mode needs indentation to work correctly, so indent after
;; backwards deleting.
;; (add-to-list 'sp--lisp-modes 'python-mode)
;; This seems to then wreck the delete forwards commands
