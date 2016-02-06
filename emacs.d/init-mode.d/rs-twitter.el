
;;; Code:

(eval-when-compile
  (require 'use-package))


(use-package twittering-mode
  :config
  (setq twittering-use-master-password t)
  (setq twittering-icon-mode t)
  (setq twittering-timer-interval 300)
  (setq twittering-url-show-status nil))

(provide 'rs-twitter)
;;; rs-twitter.el ends here
