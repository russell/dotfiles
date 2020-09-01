;;; packages.el --- rs-notmuch layer packages file for Spacemacs.
;;
;; Copyright (c) 2020 Russell Sim
;;
;; Author: Russell Sim <russell.sim@github.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst rs-notmuch-packages
  '(notmuch))

(defun rs-notmuch/post-init-notmuch ()
  (use-package notmuch
    :config
    (progn
     (set-face-attribute 'notmuch-message-summary-face
                         nil
                         :box '(:line-width 1 :color "grey75" :style released-button)
                         :background nil)
     )
    )

  (setq
   notmuch-hello-tag-list-make-query "tag:unread"
   notmuch-show-logo nil
   notmuch-fcc-dirs nil
   shr-use-colors nil
   notmuch-show-text/html-blocked-images nil
   notmuch-tag-formats '(("unread"
                          (all-the-icons-material "email" :height 0.9 :v-adjust -0.1))
                         ("flagged"
                          (all-the-icons-material "star" :height 0.9 :v-adjust -0.1)))
   notmuch-hello-sections '(notmuch-hello-insert-header
                            notmuch-hello-insert-search
                            (notmuch-hello-insert-tags-section
                             "Inbox"
                             :filter "tag:inbox and not tag:github"
                             :filter-count "tag:inbox and tag:unread and not tag:github" nil nil)
                            (notmuch-hello-insert-tags-section
                             "Github Reviews"
                             :filter "tag:github and (tag:github-mention or github-review_requested) and tag:unread"
                             :filter-count "tag:github and (tag:github-mention or github-review_requested) and tag:unread" nil nil)
                            notmuch-hello-insert-saved-searches
                            notmuch-hello-insert-recent-searches
                            notmuch-hello-insert-alltags
                            notmuch-hello-insert-footer)
   )
  )
;;; packages.el ends here
