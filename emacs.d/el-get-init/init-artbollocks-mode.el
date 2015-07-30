(require 'artbollocks-mode)

(defface rs/font-lock-passive-voice-face
  '((t (:stipple nil
                 :inverse-video nil
                 :underline "gold"
                 :slant italic)))
  "")

(defface rs/font-lock-lexical-illusions-face
  '((t (:underline "limegreen"
                   :weight bold
                   :slant italic
                   :inverse-video nil
                   :stipple nil)))
  "")

(defface rs/font-lock-weasel-words-face
  '((t (:weight bold
                :slant italic
                :inverse-video nil
                :underline "Brown"
                :stipple nil)))
  "")

(defface rs/font-lock-artbollocks-face
  '((t (:stipple nil
                 :underline "Purple"
                 :inverse-video nil
                 :slant italic
                 :weight bold)))
  "")


(custom-set-variables
 '(font-lock-lexical-illusions-face 'rs/font-lock-lexical-illusions-face)
 '(font-lock-passive-voice-face 'rs/font-lock-passive-voice-face)
 '(font-lock-weasel-words-face 'rs/font-lock-weasel-words-face)
 '(font-lock-artbollocks-face 'rs/font-lock-artbollocks-face))
