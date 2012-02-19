;; CSS
(add-hook 'css-mode-hook
	  '(lambda ()
	     (add-hook 'write-contents-functions
		       '(lambda()
			  (save-excursion
			    (delete-trailing-whitespace))))))
(add-hook 'css-mode-hook
	  '(lambda ()
	     (css-color-mode t)))
