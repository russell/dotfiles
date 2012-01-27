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

;; Offline IMAP
;(setq gnus-select-method
;      '(nnmaildir "GMail"
;		  (directory "~/Mail/GMail/")
;		  (directory-files nnheader-directory-files-safe)
;		  (get-new-mail nil)))

;; Dovecat IMAP server
;(setq gnus-select-method '(nnimap "Mail"
;				  (nnimap-address "localhost")
;				  (nnimap-stream network)
;				  (nnimap-authenticator login)))

;; Gmail IMAP server
(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; Make Gnus NOT ignore [Gmail] mailboxes
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq gnus-secondary-select-methods
      '((nnml "")
        (nntp "news.gmane.org")
	(nntp "news.eternal-september.org")))

;; don't bugger me with dribbles
(setq gnus-always-read-dribble-file t)
;; don't bugger me with session password
(setq imap-store-password t)

(setq gnus-agent-synchronize-flags t)

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
(setq mm-text-html-renderer 'w3m)
(setq mm-inline-text-html-with-images t)
(setq mm-w3m-safe-url-regexp nil)
;(setq gnus-mime-display-multipart-related-as-mixed nil)

(require 'gnus-gravatar)

(require 'gnus-sync)
(setq gnus-sync-backend '(lesync "http://marvin.webhop.net:5984/gnus")
      gnus-sync-newsrc-groups '("nntp" "nnrss")
      gnus-sync-lesync-install-topics 't
      gnus-sync-lesync-name "marvin.home")
(gnus-sync-initialize)

;; Mailing list support
(setq message-subscribed-address-functions
      '(gnus-find-subscribed-addresses))

;;
;; Gravatar
;;
(defun th-gnus-article-prepared ()
  (gnus-treat-from-gravatar)
  (gnus-treat-mail-gravatar))

(add-hook 'gnus-article-prepare-hook 'th-gnus-article-prepared)

;;
;; Check for new mail once in every this many minutes.
;;
(gnus-demon-add-handler 'gnus-group-get-new-news 2 t)
(gnus-demon-add-handler 'gnus-demon-close-connections 30 t)
(gnus-demon-init)


;;(info "(emacs-w3m) Gnus")
(defun gnus-summary-w3m-safe-toggle-inline-images (&optional arg)
  "Toggle displaying of all images in the article buffer.
          If the prefix arg is given, force displaying of images."
  (interactive "P")
  (with-current-buffer gnus-article-buffer
    (let ((st (point-min))
	  (nd (point-max))
	  (w3m-async-exec w3m-async-exec))
      (save-restriction
	(widen)
	(if (or (> st (point-min)) (< nd (point-max)))
	    (setq w3m-async-exec nil))
	(article-goto-body)
	(goto-char (or (text-property-not-all (point) (point-max)
					      'w3m-safe-url-regexp nil)
		       (point)))
	(if (interactive-p)
	    (call-interactively 'w3m-toggle-inline-images)
	  (w3m-toggle-inline-images arg))))))

(define-key gnus-summary-mode-map (kbd ">") 'gnus-summary-show-thread)
(define-key gnus-summary-mode-map (kbd "<") 'gnus-summary-hide-thread)

;;
;; Window config
;;
(gnus-add-configuration
 '(article
   (horizontal 1.0
	       (vertical 0.40
			 (group 1.0))
	       (vertical 1.0
			 (summary 0.25 point)
			 (article 1.0)))))
(gnus-add-configuration
 '(summary
   (horizontal 1.0
	       (vertical 0.40
			 (group 1.0))
	       (vertical 1.0
			 (summary 1.0 point)))))

(setq
 ;; %S   The native news server.
 ;; %M   The native select method.
 ;; %:   ":" if %S isn't "".
 ;; Gnus: pixmap if in X.
 ;; Default: "Gnus: %%b {%M%:%S}"  (%b buffer-name?)
 gnus-group-mode-line-format "Gnus: {%M%:%S}"

 ;; %M marked articles.
 ;; %S subscribed.
 ;; %p process mark.
 ;; %P topic indent.
 ;; %y number unread, unticked
 ;; %I number dormant.
 ;; %T ticked.
 ;; %D description.
 ;; %L level.
 ;; Note if add descriptions here (%D), startup is slow. No way to cache.
 ;; %c shorter than %G shorter than %g, for group name.
 ;; %G hides the method (nnfolder, etc).
 ;; %c preserves the method and last n elements of the name unexpanded,
 ;; where n is set by `gnus-group-uncollapsed-levels'.
 gnus-group-line-format "%M%S%p%P%5y: %(%-40,40G%)%l %4I\n"
)
