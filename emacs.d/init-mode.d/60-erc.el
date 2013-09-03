;; ERC
(load "~/.ercpass")

(require 'erc-services)
(erc-services-mode 1)

(setq erc-max-buffer-size 15000)

(setq erc-modules '(autojoin button completion irccontrols list
                             match move-to-prompt netsplit networks
                             noncommands readonly replace ring services
                             stamp smiley spelling truncate))

(custom-set-variables
 '(erc-insert-away-timestamp-function 'erc-insert-timestamp-left)
 '(erc-insert-timestamp-function 'erc-insert-timestamp-left)
 '(erc-timestamp-only-if-changed-flag nil)
 '(erc-track-exclude-server-buffer t)
 '(erc-track-exclude-types
   (quote
    ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE" "333" "353")))
 '(erc-header-line-face-method nil))

(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-identify-mode 'autodetect)
(setq erc-server-auto-reconnect nil)
(setq erc-server-reconnect-attempts 5)
(setq erc-server-reconnect-timeout 5)

;; try and prevent ERC from flooding the connection when trying to
;; reconnect
(setq erc-server-send-ping-timeout nil)

(add-hook 'erc-join-hook 'enable-editing-modes)

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#python"
         "#openstack" "#lisp" "#lispcafe"
         "#clnoobs")
        ("oftc.net" "#debian" "#debian-mentors")
        ("irc.in.f2l.info" "#befit")))

(defun irc-oftc ()
  (interactive)
  (erc-tls :server "irc.oftc.net" :port 6697
	   :nick "arrsim" :full-name "Russell Sim"
	   :password oftc-pass))

(defun irc-freenode ()
  (interactive)
  (erc-tls :server "irc.freenode.net" :port 6697
	   :nick "arrsim" :full-name "Russell Sim"
	   :password freenode-pass))

(defun irc-bitlbee ()
  (interactive)
  (erc :server "localhost" :port 6667
	   :nick "arrsim" :full-name "Russell Sim"
       :password bitlbee-pass))

(defun start-irc ()
  "Connect to IRC."
  (interactive)
  (setq frame-title-format '("ERC: %b"))
  (irc-oftc)
  (irc-freenode)
  (irc-bitlbee)
  (irc-f2l))
