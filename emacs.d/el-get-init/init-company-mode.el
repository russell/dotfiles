(add-hook 'after-init-hook 'global-company-mode)


(setq company-backends (remove 'company-ropemacs company-backends))
