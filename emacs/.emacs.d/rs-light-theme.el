(deftheme rs-light
  "Created 2021-07-01.")

(custom-theme-set-faces
 'rs-light
 '(window-divider ((t (:foreground "#fff"))))
 '(window-divider-last-pixel ((t (:foreground "#fff"))))
 '(window-divider-first-pixel ((t (:foreground "#fff"))))
 '(mode-line ((t (:box nil))))
 '(mode-line-inactive ((t (:box nil))))
 '(notmuch-message-summary-face ((t (:height 1.1 :inherit (modus-theme-nuanced-cyan)))))
 '(header-line ((t (:height 1.2 :foreground "#2a2a2a" :background "#e5e5e5")))))

(provide-theme 'rs-light)
