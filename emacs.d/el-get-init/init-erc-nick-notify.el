
(eval-when-compile
 (require 'use-package))

;;; Code:

(use-package erc-nick-notify
  :if dbus-runtime-version
  :config
  (setq erc-nick-notify-icon "/usr/share/pixmaps/other/IRC.png")
  :init
  (eval-after-load 'erc '(erc-nick-notify-mode t)))

(provide 'init-erc-nick-notify)

;;; init-erc-nick-notify.el ends here
