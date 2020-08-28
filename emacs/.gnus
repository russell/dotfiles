;; -*- emacs-lisp -*-
;;
;; ~/.gnus
;;
;;

;;
;; Personal settings
;;
;;; Code:

(require 'message)
(require 'gnus-util)
(require 'gnus-art)
(require 'gnus-async)
(require 'gnus-cloud)
(require 'smtpmail)

(setq gnus-cloud-epg-encrypt-to '("22B1092ADDDC47DD"))
(setq gnus-cloud-synced-files '((:directory "~/News" :match ".*.SCORE\\'")))

(setq message-from-style 'angles)

(setq gnus-buttonized-mime-types '("multipart/signed" "multipart/encrypted"
                                   "text/plain" "multipart/alternative" "text/html"))

(setq gnus-visible-headers '("^From:" "^Newsgroups:" "^Subject:" "^Date:"
                             "^Followup-To:" "^Reply-To:" "^Organization:"
                             "^Summary:" "^Keywords:" "^To:" "^[BGF]?Cc:"
                             "^Posted-To:" "^Mail-Copies-To:" "^Mail-Followup-To:"
                             "^Apparently-To:" "^Gnus-Warning:"
                             "^Resent-From:" "^User-Agent:" "^X-Mailer:"))

(require 'nnir)

(setq gnus-select-method
      '(nntp "news.gmane.io" (nnir-search-engine gmane))
      )

;; Make Gnus NOT ignore [Gmail] mailboxes
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq gnus-secondary-select-methods nil)

(add-to-list 'gnus-secondary-select-methods
             '(nnimap "cloud-sync"
                      (nnimap-address "mail.simopolis.xyz")
                      (nnimap-server-port 993)
                      (nnimap-stream tls)
                      (nnimap-authenticator login))
             )

(add-to-list 'gnus-secondary-select-methods
             '(nntp "news.eternal-september.org"))


;; don't bother me with dribbles
                                        ;(setq gnus-always-read-dribble-file t)
;; don't bother me with session password
                                        ;(setq imap-store-password t)

(setq gnus-signature-separator
      '("^-- $" "^-- *$" "^[.][.][.][.][.][.]* *$"))

(setq gnus-widen-article-window t)


;; turn on mail icon
(setq display-time-use-mail-icon t)

(setq gnus-score-over-mark (string-to-char (all-the-icons-faicon "angle-double-up")))
(setq gnus-score-below-mark (string-to-char (all-the-icons-faicon "angle-double-down")))
(setq gnus-ticked-mark (string-to-char (all-the-icons-material "star")))
(setq gnus-dormant-mark (string-to-char (all-the-icons-material "star_border")))
(setq gnus-expirable-mark (string-to-char (all-the-icons-material "delete_sweep")))
(setq gnus-read-mark (string-to-char (all-the-icons-octicon "mail")))

(setq gnus-del-mark (string-to-char (all-the-icons-material "delete_forever")))
(setq gnus-killed-mark (string-to-char (all-the-icons-material "delete")))
(setq gnus-replied-mark (string-to-char (all-the-icons-material "reply")))
(setq gnus-forwarded-mark (string-to-char (all-the-icons-material "forward")))

(setq gnus-cached-mark (string-to-char (all-the-icons-material "cached")))
(setq gnus-recent-mark (string-to-char (all-the-icons-material "fiber_new")))
(setq gnus-unseen-mark (string-to-char (all-the-icons-material "new_releases")))
(setq gnus-unread-mark (string-to-char (all-the-icons-material "markunread")))

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
       "%3{│%}" "%1{%-17,17&user-date;%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "\t"
       "%3{│%}"
       " "
       "%B"
       "%s\n"))

(setq gnus-summary-dummy-line-format
      "   %(:                                    \t:%) %S\n")

(setq gnus-summary-display-arrow t)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-summary-gather-subject-limit nil)


(setq gnus-summary-make-false-root 'adopt)
(setq gnus-simplify-ignored-prefixes "Re: ")
;; Setting this will merge all comments into the normal thread.  but
;; they will show up as blank lines.  Which makes them hard to
;; distinguish.
;; '(gnus-simplify-subject-fuzzy-regexp '(" \\[Comment\\]"))
(setq gnus-simplify-subject-functions
      '(gnus-simplify-subject gnus-simplify-subject-fuzzy gnus-simplify-whitespace))
(setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references)
(setq gnus-thread-operation-ignore-subject nil)
(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-number (not gnus-thread-sort-by-most-recent-date)))
(setq gnus-subthread-sort-functions
      '(gnus-thread-sort-by-number gnus-thread-sort-by-date))

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

;;
;; ICalendar support
;;
(require 'gnus-icalendar)
(gnus-icalendar-setup)

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
 gnus-group-line-format "%M%S%p%P%6y:%B%(%g%)\n")

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

;; Caching

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
(require 'org-mime)

;; Enable notifications

(setq gnus-notifications-use-gravatar nil)
(setq gnus-notifications-use-google-contacts nil)

(add-hook 'gnus-after-getting-new-news-hook 'gnus-notifications)

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

(defun rs/remove-address (re-address header)
  "`RE-ADDRESS' is a regular expression matching the address that
should be removed.  One way to generate such a RE is using
`REGEXP-OPT'"
  (mapconcat 'identity
             (remove-if
              (lambda (a)
                (string-match re-address a))
              (mapcar (lambda (a)
                        (while (string-match "[ \t][ \t]+" a)
                          (setq a (replace-match "" t t a)))
                        a)
                      (message-tokenize-header header)))
             ", "))



(defun rc/sent-from-unimelb-p ()
  (string-equal (message-fetch-field "Resent-From") "russell.sim@unimelb.edu.au"))


(let ((message-signature "Cheers,\nRussell\n"))
  (setq gnus-posting-styles
        `((".*"
           (x-identity "default")
           (name "Russell Sim")
           (address (with-current-buffer gnus-article-buffer
                      (if (rc/sent-from-unimelb-p)
                          "russell.sim@unimelb.edu.au"
                        "russell.sim@gmail.com")))
           (Organization (with-current-buffer gnus-article-buffer
                           (when (rc/sent-from-unimelb-p)
                             "The University of Melbourne")))
           (signature ,message-signature))
          ("^rc-"
           (x-identity "unimelb")
           (name "Russell Sim")
           (address "russell.sim@unimelb.edu.au")
           (From "russell.sim@unimelb.edu.au")
           (Organization "The University of Melbourne")
           (signature ,message-signature)))))

;;; gnus ends here
