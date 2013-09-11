(deftheme arrsim-custom
  "tsdh-dark customisations")

(custom-theme-set-variables
 'arrsim-custom
 '(rst-level-face-base-color "grey25"))

(custom-theme-set-faces
 'arrsim-custom

 '(font-lock-type-face ((t (:foreground "OliveDrab1"))))
 '(highlight-indentation-face ((t (:background "grey25"))))
 '(helm-selection ((t (:background "#00472b"))))

 ;; mumamo-mode
 '(mumamo-background-chunk-major ((t (:background "#2e3436"))))
 '(mumamo-background-chunk-submode1 ((t (:background "grey30"))))
 '(mumamo-background-chunk-submode2 ((t (:background "grey30"))))
 '(mumamo-background-chunk-submode3 ((t (:background "grey30"))))
 '(mumamo-background-chunk-submode4 ((t (:background "grey30"))))

 ;; artbollock-mode
 '(font-lock-passive-voice-face ((t (:stipple nil :inverse-video nil :underline "gold" :slant italic))))
 '(font-lock-lexical-illusions-face ((t (:underline "limegreen" :weight bold :slant italic :inverse-video nil :stipple nil))))
 '(font-lock-weasel-words-face ((t (:weight bold :slant italic :inverse-video nil :underline "Brown" :stipple nil))))
 '(font-lock-artbollocks-face ((t (:stipple nil :underline "Purple" :inverse-video nil :slant italic :weight bold))))
 '(flymake-infoline ((t (:background "#00472b"))))
 '(flymake-warnline ((t (:background "#001B63"))))

 ;; erc
 '(erc-prompt-face ((t (:inherit minibuffer-prompt))))
 '(erc-timestamp-face ((t (:foreground "peru"))))
 '(erc-notice-face ((t (:slant italic :foreground "grey30"))))

 ;; slime
 '(slime-repl-prompt-face ((t (:inherit minibuffer-prompt))))

 ;; dired
 '(diredp-exec-priv ((t nil)))
 '(diredp-no-priv ((t nil)))
 '(diredp-rare-priv ((t (:foreground "Green"))))
 '(diredp-read-priv ((t nil)))
 '(diredp-write-priv ((t nil)))

 ;; helm
 '(helm-ff-directory ((t (:foreground "light salmon"))))
 '(helm-ff-executable ((t (:foreground "SeaGreen2"))))
 '(helm-ff-file ((t (:foreground "OliveDrab1"))))
 '(helm-ff-symlink ((t (:foreground "cyan3"))))
 '(helm-selection ((t (:background "sea green"))))

 ;; email
 '(gnus-header-content ((t (:foreground "#A64B00" :height 1.1))))
 '(gnus-header-name ((t (:weight bold :height 1.2))))
 '(gnus-header-subject ((t (:foreground "yellow green" :weight bold :height 1.4))))

 ;; Jabber
 '(jabber-roster-user-online ((t (:foreground "light sea green" :weight bold))))
 '(jabber-roster-user-away ((t (:foreground "cornflower blue"))))
 '(jabber-roster-user-xa ((t (:foreground "medium purple"))))
 '(jabber-rare-time-face ((t (:foreground "#4671D5"))))
 '(jabber-chat-prompt-local ((t (:foreground "light sea green"))))
 '(jabber-chat-prompt-foreign ((t (:foreground "indian red"))))
 '(jabber-chat-prompt-system ((t (:foreground "light salmon"))))
 '(jabber-chat-error ((t (:foreground "hot pink"))))

 ;; Ansi Term
 '(term-color-black ((t (:foreground "gray20" :background "gray20"))))
 '(term-color-red ((t (:foreground "indian red" :background "indian red"))))
 '(term-color-green ((t (:foreground "light sea green" :background "light sea green"))))
 '(term-color-yellow ((t (:foreground "light salmon" :background "light salmon"))))
 '(term-color-blue ((t (:foreground "dodger blue" :background "dodger blue"))))
 '(term-color-cyan ((t (:foreground "yellow green" :background "yellow green"))))
 '(term-color-magenta ((t (:foreground "hot pink" :background "hot pink")))))

(provide-theme 'arrsim-custom)
