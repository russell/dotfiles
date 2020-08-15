
(eval-when-compile
  (require 'use-package))

;;; Code:

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(provide 'init-company-mode)

;;; init-company-mode.el ends here
