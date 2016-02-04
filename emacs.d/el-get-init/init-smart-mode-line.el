
(eval-when-compile
 (require 'use-package))

;;; Code:

(use-package smart-mode-line
  :config
  (sml/setup)
  (add-to-list 'sml/replacer-regexp-list '("^~/projects/" ":projects:") t)
  (add-hook 'after-init-hook '(lambda () (sml/apply-theme 'dark)) t))

(provide 'init-smart-mode-line)

;;; init-smart-mode-line.el ends here
