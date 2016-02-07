
;;; Code:

(eval-when-compile
  (require 'use-package))

(load "~/.jabberel")

(use-package jabber
  :defer t
  :config

  (custom-set-variables
   '(jabber-show-resources nil)
   '(jabber-alert-presence-hooks nil)
   '(jabber-history-enable-rotation t)
   '(jabber-history-enabled t)
   '(jabber-roster-line-format " %c %-25n %u %-8s  %S")
   '(jabber-roster-show-bindings nil))


  (rs/add-common-editing-hooks 'jabber-chat-mode))


(provide 'init-jabber)
;;; init-jabber.el ends here
