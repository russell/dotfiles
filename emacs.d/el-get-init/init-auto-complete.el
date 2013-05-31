(require 'auto-complete)
(add-to-list 'ac-dictionary-directories (expand-file-name "dict" pdir))
(require 'auto-complete-config)
(ac-config-default)

;; custom keybindings to use tab, enter and up and down arrows
(define-key ac-complete-mode-map "\C-s" 'ac-isearch)

(custom-set-variables
 '(ac-trigger-key "TAB")
 '(ac-disable-inline t)
 '(ac-dwim t))

;; SLIME
(add-hook 'slime-mode-hook
          '(lambda ()
             (require 'ac-slime)
             (setq ac-sources '(ac-source-abbrev
                                ac-source-words-in-same-mode-buffers
                                ac-source-slime-fuzzy))))

(add-hook 'python-mode-hook
          '(lambda ()
             (setq ac-sources '(ac-source-yasnippet
                                ac-source-abbrev
                                ac-source-words-in-same-mode-buffers
                                ac-source-jedi-direct))))
