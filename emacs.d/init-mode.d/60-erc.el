;; ERC
(load "~/.ercpass")

(require 'erc-services)
(erc-services-mode 1)

(setq erc-max-buffer-size 10000)

(setq erc-modules (quote (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly replace ring services stamp smiley spelling truncate highlight-nicknames)))

(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-identify-mode 'autodetect)
(setq erc-server-reconnect-attempts 5)
(setq erc-server-reconnect-timeout 5)

;; try and prevent ERC from flooding the connection when trying to
;; reconnect
(setq erc-server-send-ping-timeout nil)

(add-hook 'erc-join-hook 'enable-editing-modes)

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#python"
         "#twisted" "#twisted.web" "#pylons"
         "#pyramid" "#openstack" "#lisp" "#lispcafe"
         "#clnoobs")
        ("oftc.net" "#debian" "#debian-mentors"
         "#debian-python" "#debian-gnome")
        ("austnet.org" "#nectar")))

(defun start-irc ()
  "Connect to IRC."
  (interactive)
  (setq frame-title-format '("ERC: %b"))
  (erc-tls :server "irc.oftc.net" :port 6697
	   :nick "arrsim" :full-name "Russell Sim"
	   :password oftc-pass)
  (erc-tls :server "irc.freenode.net" :port 6697
	   :nick "arrsim" :full-name "Russell Sim"
	   :password freenode-pass)
  (erc-tls :server "scoutlan.qld.au.austnet.org" :port 6697
           :nick "arrsim" :full-name "Russell Sim"
           :password austnet-pass))
