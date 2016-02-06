
;;; Code:

(eval-when-compile
  (require 'use-package))

(load "~/.ercpass")

(use-package erc
  :config

  (require 'erc-services)
  (erc-services-mode 1)

  (use-package erc-truncate
    :config
    (setq erc-max-buffer-size 15000))

  (setq erc-modules '(autojoin button completion irccontrols list
                               match move-to-prompt netsplit networks
                               noncommands readonly replace ring services
                               notifications stamp smiley spelling
                               truncate track))

  (custom-set-variables
   '(erc-insert-away-timestamp-function 'erc-insert-timestamp-left)
   '(erc-insert-timestamp-function 'erc-insert-timestamp-left)
   '(erc-timestamp-only-if-changed-flag nil)
   '(erc-track-exclude-server-buffer t)

   '(erc-header-line-face-method nil))


  (use-package erc-track
    :config
    (setq  erc-track-faces-priority-list
           '(erc-error-face
             (erc-nick-default-face erc-current-nick-face)
             erc-current-nick-face erc-keyword-face
             (erc-nick-default-face erc-pal-face)
             erc-pal-face erc-nick-msg-face erc-direct-msg-face
             (erc-nick-default-face erc-dangerous-host-face)
             erc-dangerous-host-face erc-nick-default-face
             erc-action-face
             (erc-nick-default-face erc-fool-face)
             erc-fool-face erc-notice-face erc-input-face erc-prompt-face))

    (setq erc-track-exclude-types
          '("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE" "333" "353"))
    (setq erc-track-priority-faces-only
          '("#clnoob" "#debian" "#debian-mentors" "#emacs"
            "#lisp" "#lispcafe" "#openstack" "#python")))

  (use-package erc-services
    :config
    (setq erc-prompt-for-nickserv-password nil)
    (setq erc-nickserv-identify-mode 'autodetect))

  (setq erc-server-auto-reconnect nil)
  (setq erc-server-reconnect-attempts 5)
  (setq erc-server-reconnect-timeout 5)


  ;; Make query buffers have a high priority
  (defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
    (if (erc-query-buffer-p)
        (setq ad-return-value (intern "erc-current-nick-face"))
      ad-do-it))

  ;; Try and prevent ERC from flooding the connection when trying to
  ;; reconnect
  (setq erc-server-send-ping-timeout nil)
  (add-hook 'erc-join-hook 'enable-editing-modes)
  (add-hook 'erc-text-matched-hook 'erc-global-notify))

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
    (znc-all)
    (irc-bitlbee)))

(require 'notifications)
(defun erc-global-notify (match-type nick message)
  "Notify when a message is recieved."
  (notifications-notify
   :title nick
   :body message
   :urgency 'low))

(provide 'rs-erc)
;;; rs-erc.el ends here
