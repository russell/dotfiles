;;; Don't show dialogs
(setq use-dialog-box nil)


;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
(if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)

;; disable the toolbar, scroll bar and menu bar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;; Display file size in Modeline
(size-indication-mode 1)

(setq custom-enabled-themes (quote (tango-plus)))
(setq custom-safe-themes t)

(defun tango-plus ()
  "re-init the tango plus theme."
  (interactive)
  (load-theme 'tango-plus))
