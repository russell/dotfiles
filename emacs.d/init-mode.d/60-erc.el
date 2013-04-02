;; ERC
(load "~/.ercpass")

(require 'erc-services)
(erc-services-mode 1)

(setq erc-max-buffer-size 10000)

(setq erc-modules '(autojoin button completion fill irccontrols list
                             match menu move-to-prompt netsplit networks
                             noncommands readonly replace ring services
                             stamp smiley spelling truncate highlight-nicknames track))

(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-identify-mode 'autodetect)
(setq erc-server-auto-reconnect nil)
(setq erc-server-reconnect-attempts 5)
(setq erc-server-reconnect-timeout 5)
(setq erc-nick-notify-icon "/usr/share/pixmaps/other/IRC.png")

;; try and prevent ERC from flooding the connection when trying to
;; reconnect
(setq erc-server-send-ping-timeout nil)

(add-hook 'erc-join-hook 'enable-editing-modes)

;;; erc-nick-notify
(autoload 'erc-nick-notify-mode "erc-nick-notify"
  "Minor mode that calls `erc-nick-notify-cmd' when his nick gets
mentioned in an erc channel" t)
(eval-after-load 'erc '(erc-nick-notify-mode t))

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
       :password "vi8huoKo"))

(defun irc-f2l ()
  (interactive)
  (erc :server "irc.in.f2l.info" :port 6667
	   :nick "arrsim" :full-name "Russell Sim"))

(defun start-irc ()
  "Connect to IRC."
  (interactive)
  (setq frame-title-format '("ERC: %b"))
  (irc-oftc)
  (irc-freenode)
  (irc-bitlbee)
  (irc-f2l))
