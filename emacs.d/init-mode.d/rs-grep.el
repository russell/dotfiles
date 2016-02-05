
(require 'use-package)

;;; Code:

(use-package grep
  :config
  (add-to-list 'grep-find-ignored-directories ".tox")
  (add-to-list 'grep-find-ignored-directories ".venv"))

(provide 'rs-grep)
;;; rs-grep.el ends here
