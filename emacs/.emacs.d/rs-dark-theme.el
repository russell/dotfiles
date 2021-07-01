(deftheme rs-dark
  "Created 2021-07-01.")

(custom-theme-set-faces
 'rs-dark
 '(window-divider ((t (:foreground "#000000"))))
 '(window-divider-last-pixel ((t (:foreground "#000000"))))
 '(window-divider-first-pixel ((t (:foreground "#000000"))))
 '(mode-line ((t (:box nil))))
 '(mode-line-inactive ((t (:box nil))))
 '(notmuch-message-summary-face ((t (:inherit (bold modus-themes-nuanced-cyan) :height 1.1))))
 '(header-line ((t (:background "#212121" :foreground "#dddddd" :height 1.2)))))

(provide-theme 'rs-dark)
