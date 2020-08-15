
;;; Code:

;;; Don't show dialogs
(setq use-dialog-box nil)

; set font
(require 'cl)
(defun rs/font-candidate (&rest fonts)
  "Return existing font which first match."
  (find-if (lambda (f) (find-font (font-spec :name f))) fonts))
(set-face-attribute 'default nil
                    :font (rs/font-candidate "Hack:pixelsize=14"
                                             "DejaVu Sans Mono:pixelsize=14"))

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

;; disable all popup tooltips.  They don't work well on OSX
(tooltip-mode -1)

(setq mode-line-format
      '("%e"
        mode-line-front-space
        mode-line-mule-info
        mode-line-client
        mode-line-modified
        mode-line-remote
        mode-line-frame-identification
        mode-line-buffer-identification
        "   "
        (po-mode-flag ("  " po-mode-line-string))
        mode-line-position
        (vc-mode vc-mode)
        "  "
        mode-line-misc-info
        mode-line-modes
        mode-line-end-spaces))

;;; Display file size in Modeline
(size-indication-mode 1)

(defun rs/rotate-windows ()
  "Rotate your windows"
  (interactive)
  (let (i numWindows)
    (cond
     ((not (> (count-windows)1))
      (message "You can't rotate a single window!"))
     (t
      (setq i 1)
      (setq numWindows (count-windows))
      (while (< i numWindows)
        (let* ((w1 (elt (window-list) i))
               (w2 (elt (window-list) (+ (% i numWindows) 1)))

               (b1 (window-buffer w1))
               (b2 (window-buffer w2))

               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))

(global-set-key (kbd "C-x -") 'rs/rotate-windows)

(when (getenv "DISPLAY")
  (setq browse-url-browser-function 'browse-url-xdg-open))

(provide 'rs-gui)
;;; rs-gui.el ends here
