(custom-set-variables
 '(jabber-show-resources nil)
 '(jabber-alert-presence-hooks nil)
 '(jabber-history-enable-rotation t)
 '(jabber-history-enabled t)
 '(jabber-roster-line-format " %c %-25n %u %-8s  %S")
 '(jabber-roster-show-bindings nil))

(load "~/.jabberel")

(add-hook 'jabber-chat-mode-hook 'enable-editing-modes)
