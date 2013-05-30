(global-set-key "\M-y" 'helm-show-kill-ring)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
;; Jump to a definition in the current file. (This is awesome)
(global-set-key (kbd "C-x C-i") 'helm-imenu)

(require 'helm-match-plugin)
