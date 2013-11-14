;; -*- emacs-lisp -*-
;;
;; ~/.gnus
;;
;;

;;
;; Personal settings
;;
(setq message-from-style 'angles)

(setq gnus-buttonized-mime-types '("multipart/signed" "multipart/encrypted"))
(setq gnus-visible-headers '("^From:" "^Newsgroups:" "^Subject:" "^Date:"
                             "^Followup-To:" "^Reply-To:" "^Organization:"
                             "^Summary:" "^Keywords:" "^To:" "^[BGF]?Cc:"
                             "^Posted-To:" "^Mail-Copies-To:" "^Mail-Followup-To:"
                             "^Apparently-To:" "^Gnus-Warning:"
                             "^Resent-From:" "^User-Agent:"))
(setq mm-verify-option 'known)
(setq mm-decrypt-option 'known)
(setq mml-smime-signers (quote ("27E94A1A")))
(setq mm-discouraged-alternatives
      '("multipart/related" "text/html" "text/richtext")
      mm-automatic-display
      (remove "text/html" mm-automatic-display))

(require 'nnir)

;; Dovecat IMAP server
(setq gnus-select-method '(nnimap "Mail"
				  (nnimap-address "localhost")
				  (nnimap-stream network)
				  (nnimap-authenticator login)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; Make Gnus NOT ignore [Gmail] mailboxes
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq gnus-secondary-select-methods
      '((nntp "news.gmane.org")
        (nntp "news.eternal-september.org")))

;; don't bother me with dribbles
;(setq gnus-always-read-dribble-file t)
;; don't bother me with session password
;(setq imap-store-password t)

(setq gnus-asynchronous t)
(setq gnus-widen-article-window t)


;; turn on mail icon
(setq display-time-use-mail-icon t)

(setq gnus-score-over-mark ?↑)          ; ↑ ☀
(setq gnus-score-below-mark ?↓)         ; ↓ ☂
(setq gnus-ticked-mark ?⚑)
(setq gnus-dormant-mark ?⚐)
(setq gnus-expirable-mark ?♻)
(setq gnus-read-mark ?✓)
(setq gnus-del-mark ?✗)
(setq gnus-killed-mark ?☠)
(setq gnus-replied-mark ?↺)
(setq gnus-forwarded-mark ?↪)

(setq gnus-cached-mark ?☍)
(setq gnus-recent-mark ?★)
(setq gnus-unseen-mark ?✩)
(setq gnus-unread-mark ?✉)

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
  (setq gnus-sum-thread-tree-root "● ") ;; "● ")
  (setq gnus-sum-thread-tree-false-root "◯ ") ;; "◯ ")
  (setq gnus-sum-thread-tree-single-indent "◎ ") ;; "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-face-9 'font-lock-warning-face)
(setq gnus-face-10 'shadow)

(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "\t"
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-number
	(not gnus-thread-sort-by-most-recent-date)
	gnus-thread-sort-by-total-score))

(setq gnus-thread-sort-functions '(gnus-thread-sort-by-number
      (not gnus-thread-sort-by-most-recent-date)))

; w3m
(setq mm-text-html-renderer 'shr)

(setq shr-blocked-images nil)
(setq mm-inline-text-html-with-images t)
(setq shr-color-visible-distance-min 10)
(setq shr-color-visible-luminance-min 80)
(setq mm-w3m-safe-url-regexp nil)

;(setq gnus-mime-display-multipart-related-as-mixed nil)

(require 'gnus-gravatar)

;; Mailing list support
(setq message-subscribed-address-functions
      '(gnus-find-subscribed-addresses))

;;
;; Gravatar
;;
(setq gnus-treat-from-gravatar 'head)
(setq gnus-treat-mail-gravatar 'head)


(add-hook 'gnus-article-prepare-hook 'th-gnus-article-prepared)

;;
;; Check for new mail once in every this many minutes.
;;
(gnus-demon-add-handler 'gnus-demon-scan-news 20 2)
(gnus-demon-add-handler 'gnus-demon-scan-timestamps nil 30)
(gnus-demon-add-nntp-close-connection)
(gnus-demon-add-disconnection)

(defun gmail-delete ()
  "Move the current message to the bin."
  (interactive)
  (gnus-summary-move-article nil "[Google Mail]/Bin"))

(define-key gnus-summary-backend-map (kbd "k") 'gmail-delete)

(defun gmail-report-spam ()
  "Mark the current message as spam."
  (interactive)
  (gnus-summary-move-article nil "[Google Mail]/Spam"))

(define-key gnus-summary-backend-map (kbd "s") 'gmail-report-spam)

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
   (vertical 1.0
			 (summary 0.25 point)
			 (article 1.0))))

(setq
 ;; %S   The native news server.
 ;; %M   The native select method.
 ;; %:   ":" if %S isn't "".
 ;; Gnus: pixmap if in X.
 ;; Default: "Gnus: %%b {%M%:%S}"  (%b buffer-name?)
 gnus-group-mode-line-format "Gnus: {%M%:%S}"

 ;; %G  Group name
 ;; %p  Unprefixed group name
 ;; %A  Current article number
 ;; %z  Current article score
 ;; %V  Gnus version
 ;; %U  Number of unread articles in the group
 ;; %e  Number of unselected articles in the group
 ;; %Z  A string with unread/unselected article counts
 ;; %g  Shortish group name
 ;; %S  Subject of the current article
 ;; %u  User-defined spec
 ;; %s  Current score file name
 ;; %d  Number of dormant articles
 ;; %r  Number of articles that have been marked as read in this session
 ;; %E  Number of articles expunged by the score files
 gnus-summary-mode-line-format "Gnus: %G [%A] %Z"

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
 gnus-group-line-format "%M%S%p%P%5y: %(%-40,40G%)%l %4I\n")

(setq gnus-use-adaptive-scoring t)
(setq gnus-score-expiry-days 30)
(setq gnus-default-adaptive-score-alist
      '((gnus-unread-mark)
        (gnus-ticked-mark (from 4))
        (gnus-dormant-mark (from 5))
        (gnus-saved-mark (from 20) (subject 5))
        (gnus-del-mark (from -2) (subject -5))
        (gnus-read-mark (from 2) (subject 2))
        (gnus-killed-mark (from -1) (subject -3))
        (gnus-kill-file-mark)
        (gnus-ancient-mark)
        (gnus-low-score-mark)
        (gnus-catchup-mark (from -1) (subject -1))))
(setq gnus-use-adaptive-scoring '(word line))

(add-hook 'message-sent-hook 'gnus-score-followup-article)
(add-hook 'message-sent-hook 'gnus-score-followup-thread)

(setq plstore-cache-passphrase-for-symmetric-encryption t)

(setq gnus-message-archive-group
      '((if (message-news-p)
            "sent-news"
          "sent-mail")))

;;
;; GPG
;;

;; regexp of groups from which new messages are mime signed by default
(setq my-sign-mime-group-regexp "^\\(INBOX\\|gmane.linux.debian.\\*\\)$")

;; hook to setup message
(defun my-mml-secure-message-sign-mime ()
  (when (and gnus-newsgroup-name
             (member (cadr gnus-current-select-method) '("gmail"))
             (string-match
              my-sign-mime-group-regexp
              gnus-newsgroup-name))
    (mml-secure-message-sign-pgpmime)))

;; plug this into message-setup-hook
(add-hook 'message-setup-hook 'my-mml-secure-message-sign-mime)

;; cacheing

(setq gnus-use-cache t)
(setq gnus-cache-directory "~/Mail/cache/")
(setq gnus-cache-enter-articles '(ticked dormant read unread))
(setq gnus-cache-remove-articles nil)
(setq gnus-cacheable-groups "^nnimap")

;;
;; RSS
;;

;; convert atom to rss
(require 'mm-url)
(defadvice mm-url-insert (after DE-convert-atom-to-rss () )
  "Converts atom to RSS by calling xsltproc."
  (when (re-search-forward "xmlns=\"http://www.w3.org/.*/Atom\""
			   nil t)
    (goto-char (point-min))
    (message "Converting Atom to RSS... ")
    (call-process-region (point-min) (point-max)
			 "xsltproc"
			 t t nil
			 (expand-file-name "~/.emacs.d/atom2rss.xsl") "-")
    (goto-char (point-min))
    (message "Converting Atom to RSS... done")))

(ad-activate 'mm-url-insert)

;; Render org files to email.
;; (require 'org-mime)

;;
(require 'gnus-desktop-notify)
(gnus-desktop-notify-mode)

(defun my-gnus-summary-view-html-alternative-in-xdg ()
  "Display the HTML part of the current multipart/alternative MIME message
    in xdg browser."
  (interactive)
  (save-current-buffer
    (gnus-summary-show-article)
    (set-buffer gnus-article-buffer)
    (let ((file (make-temp-file "html-message-" nil ".html"))
          (handle (cdr (assq 1 gnus-article-mime-handle-alist))))
      (mm-save-part-to-file handle file)
      (browse-url-xdg-open (concat "file://" file)))))


(setq gnus-posting-styles
      '((".*"
         (From (with-current-buffer gnus-article-buffer
                 (or (message-fetch-field "Resent-From")
                     "russell.sim@gmail.com")))
         (Organization (with-current-buffer gnus-article-buffer
                         (when (message-fetch-field "Resent-From")
                           "The University of Melbourne"))))
        ("^rc-"
         (From "russell.sim@unimelb.edu.au")
         (Organization "The University of Melbourne"))))
