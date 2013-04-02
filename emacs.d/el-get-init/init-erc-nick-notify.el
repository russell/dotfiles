
(setq erc-nick-notify-icon "/usr/share/pixmaps/other/IRC.png")

;;; erc-nick-notify
(autoload 'erc-nick-notify-mode "erc-nick-notify"
  "Minor mode that calls `erc-nick-notify-cmd' when his nick gets
mentioned in an erc channel" t)
(eval-after-load 'erc '(erc-nick-notify-mode t))
