
;;; Code:

(require 'use-package)

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this)
  ("C-*" . mc/mark-all-like-this))

(provide 'rs-multiple-cursors)
;;; rs-multiple-cursors.el ends here
