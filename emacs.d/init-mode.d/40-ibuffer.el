; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("erc" (mode . erc-mode))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*.*\\*$")
			 (name . "^\\*Messages\\*$")))
	       ("org" (mode . org-mode))
	       ("gnus" (or
			(mode . message-mode)
			(mode . mail-mode)
			(mode . gnus-group-mode)
			(mode . gnus-summary-mode)
			(mode . gnus-article-mode)
			(name . "^\\.newsrc-dribble")))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))
