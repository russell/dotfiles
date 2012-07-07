(setq bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")

(defun my-bookmark-set ()
  "Set a bookmark at the current buffer and current position."
  (interactive)
  (bookmark-set (format "%s" (which-function)))
  (message "bookmark is set for the current position."))
