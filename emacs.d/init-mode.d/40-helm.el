(require 'helm-match-plugin)
(require 'helm-files)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
;; Jump to a definition in the current file. (This is awesome)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
