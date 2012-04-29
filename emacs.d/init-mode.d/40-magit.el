
;; Add mode hooks for magit commit mode
(add-hook 'magit-commit-mode-hook
          'auto-capitalize-mode)
(add-hook 'magit-commit-mode-hook
          'flyspell-mode)
(add-hook 'magit-commit-mode-hook
          'turn-on-artbollocks-mode)
