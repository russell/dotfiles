; IDO
(require 'ido)
(ido-mode)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t) ;; enable fuzzy matching
(setq ido-everywhere t)
(setq ido-mode 'both)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-enter-matching-directory (quote first))
(setq ido-ignore-files (quote ("\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./" "\\`\\.DS_Store" "\\`\\.localized" "\\.sparsebundle/" "\\.dmg\\'")))
(setq ido-use-virtual-buffers t)


(global-set-key (kbd "C-x B") 'ido-switch-buffer-other-window)
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)

(set-default 'imenu-auto-rescan t)
