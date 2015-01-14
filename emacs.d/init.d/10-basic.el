;;; Personal Stuff
(setq user-full-name "Russell Sim")
(setq user-mail-address "russell.sim@gmail.com")

(setq confirm-kill-emacs (quote yes-or-no-p))

(setq inhibit-startup-screen t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

; title format
(setq frame-title-format "%b - emacs")

(setq message-log-max 1000)

(require 'ibuffer)
