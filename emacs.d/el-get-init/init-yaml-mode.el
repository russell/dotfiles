
(eval-when-compile
  (require 'use-package))

;;; Code:

(use-package yaml-mode
  :config
  (add-hook 'yaml-mode-hook
	  '(lambda ()
	     (add-hook 'write-contents-functions
                   'delete-trailing-whitespace))))

(provide 'init-yaml-mode)
;;; init-yaml-mode.el ends here
