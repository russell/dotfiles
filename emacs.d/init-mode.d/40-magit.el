
;; Add mode hooks for magit commit mode
(add-hook 'magit-log-edit-mode-hook
          'auto-capitalize-mode)
(add-hook 'magit-log-edit-mode-hook
          'flyspell-mode)
(add-hook 'magit-log-edit-mode-hook
          'turn-on-artbollocks-mode)
