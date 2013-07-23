(deftheme arrsim-custom
  "tsdh-dark customisations")

(custom-theme-set-variables
 'arrsim-custom
 '(rst-level-face-base-color "grey25"))

(custom-theme-set-faces
 'arrsim-custom

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

 ;; slime
 '(slime-repl-prompt-face ((t (:inherit minibuffer-prompt))))

 ;; dired
 '(diredp-exec-priv ((t nil)))
 '(diredp-no-priv ((t nil)))
 '(diredp-rare-priv ((t (:foreground "Green"))))
 '(diredp-read-priv ((t nil)))
 '(diredp-write-priv ((t nil)))

 ;; email
 '(gnus-header-content ((t (:foreground "#A64B00" :height 1.1))))
 '(gnus-header-name ((t (:weight bold :height 1.2))))
 '(gnus-header-subject ((t (:foreground "yellow green" :weight bold :height 1.4))))

 ;; Ansi Term
 '(term-color-black ((t (:foreground "gray20" :background "gray20"))))
 '(term-color-red ((t (:foreground "indian red" :background "indian red"))))
 '(term-color-green ((t (:foreground "light sea green" :background "light sea green"))))
 '(term-color-yellow ((t (:foreground "light salmon" :background "light salmon"))))
 '(term-color-blue ((t (:foreground "dodger blue" :background "dodger blue"))))
 '(term-color-cyan ((t (:foreground "yellow green" :background "yellow green"))))
 '(term-color-magenta ((t (:foreground "hot pink" :background "hot pink")))))

(provide-theme 'arrsim-custom)
