
;;; Code:

(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (add-hook 'write-contents-functions
		       '(lambda()
			  (save-excursion
			    (delete-trailing-whitespace))))))


(provide 'init-yaml-mode)
;;; init-yaml-mode.el ends here
