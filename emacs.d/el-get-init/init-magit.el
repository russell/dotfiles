
;; Add mode hooks for magit commit mode
(add-hook 'magit-log-edit-mode-hook 'auto-capitalize-mode)
(add-hook 'magit-log-edit-mode-hook 'flyspell-mode)
(add-hook 'magit-log-edit-mode-hook 'turn-on-artbollocks-mode)

;; Git-Commit-Mode
(add-hook 'git-commit-mode-hook 'turn-on-flyspell)
(add-hook 'git-commit-mode-hook 'auto-capitalize-mode)
(add-hook 'git-commit-mode-hook 'turn-on-artbollocks-mode)
(add-hook 'git-commit-mode-hook (lambda () (toggle-save-place 0)))


(setq magit-set-upstream-on-push 'dontask)

;; (magit-wip-mode 1)
;; (global-magit-wip-save-mode 1)
(eval-after-load "magit"
  '(add-hook 'magit-refresh-file-buffer-hook
             'diff-hl-update))
