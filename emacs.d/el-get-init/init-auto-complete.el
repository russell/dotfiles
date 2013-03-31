(require 'auto-complete)
(add-to-list 'ac-dictionary-directories (expand-file-name "dict" pdir))
;; (require 'auto-complete-config)
;; (ac-config-default)

;; custom keybindings to use tab, enter and up and down arrows
(define-key ac-complete-mode-map "\t" 'ac-expand)
(define-key ac-complete-mode-map "\r" 'ac-complete)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)

;; Live completion with auto-complete
;; (see http://cx4a.org/software/auto-complete/)
(require 'auto-complete-config nil t)
;; Do What I Mean mode

(custom-set-variables
 '(ac-trigger-key "TAB")
 '(ac-use-menu-map t)
 '(ac-dwim t))

;; SLIME
(add-hook 'slime-mode-hook
          '(lambda ()
             (require 'ac-slime)
             (setq ac-sources '(ac-source-abbrev ac-source-words-in-same-mode-buffers
                                                 ac-source-slime-fuzzy))))
