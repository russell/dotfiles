;; -*- emacs-lisp -*-
;;
;; ~/.gnus
;;
;;

;;
;; Personal settings
;;
(setq message-from-style 'angles)


; gnus
(setq gnus-select-method '(nnimap "Mail"
				  (nnimap-address "localhost")
				  (nnimap-stream network)
				  (nnimap-authenticator login)))
;(setq gnus-select-method '(nnimap "gmail"
;				  (nnimap-address "imap.gmail.com")
;				  (nnimap-server-port 993)
;				  (nnimap-stream ssl)))
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)
;; Make Gnus NOT ignore [Gmail] mailboxes
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq gnus-secondary-select-methods
      '((nnml "")
        (nntp "news.gmane.org")))

;; don't bugger me with dribbles
(setq gnus-always-read-dribble-file t)
;; don't bugger me with session password
(setq imap-store-password t)

(defun gnus-user-format-function-@ (header)
  "Display @ for message with attachment in summary line.
You need to add `Content-Type' to `nnmail-extra-headers' and
`gnus-extra-headers', see Info node `(gnus)To From Newsgroups'."
  (let ((case-fold-search t)
	(ctype (or (cdr (assq 'Content-Type (mail-header-extra header)))
		   "text/plain"))
	indicator)
    (when (string-match "^multipart/mixed" ctype)
      (setq indicator "@"))
    (if indicator
	indicator
      " ")))

(defalias 'gnus-user-format-function-score 'rs-gnus-summary-line-score)

(defun rs-gnus-summary-line-score (head)
  "Return pretty-printed version of article score.

See (info \"(gnus)Group Line Specification\")."
  (let ((c (gnus-summary-article-score (mail-header-number head))))
    ;; (gnus-message 9 "c=%s chars in article %s" c (mail-header-number head))
    (cond ((< c -1000)     "vv")
          ((< c  -100)     " v")
          ((< c   -10)     "--")
          ((< c     0)     " -")
          ((= c     0)     "  ")
          ((< c    10)     " +")
          ((< c   100)     "++")
          ((< c  1000)     " ^")
          (t               "^^")))) 

;; http://groups.google.com/group/gnu.emacs.gnus/browse_thread/thread/a673a74356e7141f
(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "") ;; "● ")
  (setq gnus-sum-thread-tree-false-root "") ;; "◯ ")
  (setq gnus-sum-thread-tree-single-indent "") ;; "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-face-9 'font-lock-warning-face)
(setq gnus-face-10 'shadow) 
(setq gnus-summary-line-format
        (concat
         "%0{%U%R%z%}" "%10{|%}" "%1{%d%}" "%10{|%}"
         "%9{%u&@;%}" "%(%-15,15f %)" "%10{│%}" "%4k" "%10{|%}"
         "%2u&score;" "%10{|%}" "%10{%B%}" "%s\n"))
(setq gnus-summary-display-arrow t)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

; w3m
(setq gnus-mime-display-multipart-related-as-mixed nil)
(setq gnus-article-wash-function 'w3)
(setq mm-text-html-renderer 'w3)
(setq mm-inline-text-html-with-images t)
;(setq mm-inline-text-html-with-w3m-keymap nil)

; gravater
(defun th-gnus-article-prepared ()
  (gnus-treat-from-gravatar)
  (gnus-treat-mail-gravatar))

(add-hook 'gnus-article-prepare-hook 'th-gnus-article-prepared)

;;
;; Check for new mail once in every this many minutes.
;;
(gnus-demon-add-handler 'gnus-demon-add-scanmail 5 t)
(gnus-demon-add-handler 'gnus-demon-add-rescan 10 t)
(gnus-demon-add-handler 'gnus-demon-close-connections 30 t)
(gnus-demon-init)
