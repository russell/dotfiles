(global-set-key "\M-y" 'helm-show-kill-ring)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
;; Jump to a definition in the current file. (This is awesome)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "M-x") 'helm-M-x)

(require 'helm-match-plugin)
