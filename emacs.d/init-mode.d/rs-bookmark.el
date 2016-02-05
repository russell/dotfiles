
;;; Code:

(require 'use-package)

(use-package bookmark+
  :config
  (setq bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")

  (defun rs/bookmark-set ()
    "Set a bookmark at the current buffer and current position."
    (interactive)
    (bookmark-set (format "%s" (which-function)))
    (message "bookmark is set for the current position.")))

(provide 'rs-bookmark)
;;; rs-bookmark.el ends here
