;; ERC
(load "~/.ercpass")

(require 'erc-services)
(erc-services-mode 1)

(setq erc-max-buffer-size 15000)

(setq erc-modules '(autojoin button completion irccontrols list
                             match move-to-prompt netsplit networks
                             noncommands readonly replace ring services
                             stamp smiley spelling truncate track))

(custom-set-variables
 '(erc-insert-away-timestamp-function 'erc-insert-timestamp-left)
 '(erc-insert-timestamp-function 'erc-insert-timestamp-left)
 '(erc-timestamp-only-if-changed-flag nil)
 '(erc-track-exclude-server-buffer t)
 '(erc-track-priority-faces-only 'all)
 '(erc-track-exclude-types
   (quote
    ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE" "333" "353")))
 '(erc-header-line-face-method nil)
 '(erc-track-faces-priority-list '(erc-error-face
                                   erc-current-nick-face
                                   erc-keyword-face
                                   erc-nick-msg-face
                                   erc-direct-msg-face
                                   erc-dangerous-host-face
                                   erc-notice-face
                                   erc-prompt-face)))

(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-identify-mode 'autodetect)
(setq erc-server-auto-reconnect nil)
(setq erc-server-reconnect-attempts 5)
(setq erc-server-reconnect-timeout 5)


;; Make query buffers have a high priority
(defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p)
      (setq ad-return-value (intern "erc-current-nick-face"))
    ad-do-it))

(defadvice erc-track-modified-channels (around erc-track-modified-channels-promote-query activate)
  (if (erc-query-buffer-p) (setq erc-track-priority-faces-only 'nil))
  ad-do-it
  (if (erc-query-buffer-p) (setq erc-track-priority-faces-only 'all)))


;; try and prevent ERC from flooding the connection when trying to
;; reconnect
(setq erc-server-send-ping-timeout nil)

(add-hook 'erc-join-hook 'enable-editing-modes)

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#python"
         "#openstack" "#lisp" "#lispcafe"
         "#clnoobs")
        ("oftc.net" "#debian" "#debian-mentors")))

(defun irc-oftc ()
  (interactive)
  (let ((default-directory (expand-file-name "~")))
    (erc-tls :server "irc.oftc.net" :port 6697
             :nick "arrsim" :full-name "Russell Sim"
             :password oftc-pass)))

(defun irc-freenode ()
  (interactive)
  (let ((default-directory (expand-file-name "~")))
    (erc-tls :server "chat.freenode.net" :port 6697
             :nick "arrsim" :full-name "Russell Sim"
             :password freenode-pass)))

(defun irc-bitlbee ()
  (interactive)
  (let ((default-directory (expand-file-name "~")))
    (erc :server "localhost" :port 6667
         :nick "arrsim" :full-name "Russell Sim"
         :password bitlbee-pass)))

(defun start-irc ()
  "Connect to IRC."
  (interactive)
  (let ((default-directory (expand-file-name "~")))
    (irc-oftc)
    (irc-freenode)
    (irc-bitlbee)))


(require 'notifications)
(defun erc-global-notify (match-type nick message)
  "Notify when a message is recieved."
  (notifications-notify
   :title nick
   :body message
   :urgency 'low))

(add-hook 'erc-text-matched-hook 'erc-global-notify)
