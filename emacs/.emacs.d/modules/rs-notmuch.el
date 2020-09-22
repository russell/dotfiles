;;; rs-notmuch.el --- NotMuch                        -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Russell Sim

;; Author: Russell Sim <russell.sim@gmail.com>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(prelude-require-packages '(notmuch))

(use-package shr
  :config
  (progn
    (setq shr-use-colors nil)))

(use-package notmuch
  :bind
  (:map
   rs-applications-map
   ("n" . notmuch)
   :map
   notmuch-show-mode-map
   ("C-c C-o" . org-open-at-point))
  :init
  (setq
   notmuch-hello-tag-list-make-query "tag:unread"
   notmuch-show-logo nil
   notmuch-fcc-dirs nil
   notmuch-archive-tags '("-inbox" "-flagged")
   notmuch-show-text/html-blocked-images nil
   notmuch-tag-formats '(("unread"
                          (all-the-icons-material "email" :height 0.9 :v-adjust -0.2))
                         ("flagged"
                          (all-the-icons-material "star" :height 0.9 :v-adjust -0.2))
                         ("github-merged"
                          (all-the-icons-octicon "git-branch" :height 0.9 :v-adjust 0.0))
                         ("Archive"
                          (all-the-icons-material "save" :height 0.9 :v-adjust -0.2)))
   notmuch-hello-sections '(notmuch-hello-insert-header
                            notmuch-hello-insert-search
                            (notmuch-hello-insert-tags-section
                             "Flagged"
                             :filter "tag:flagged and tag:inbox and NOT (tag:deleted or tag:spam)"
                             :filter-count "tag:flagged and tag:inbox and NOT (tag:deleted or tag:spam)" nil nil)
                            (notmuch-hello-insert-tags-section
                             "Inbox"
                             :filter "tag:inbox and NOT (tag:deleted or tag:spam)"
                             :filter-count "tag:inbox and tag:unread and NOT (tag:deleted or tag:spam)" nil nil)
                            (notmuch-hello-insert-tags-section
                             "Github Reviews"
                             :filter "tag:github and (tag:github-mention or github-review_requested) and (tag:unread or tag:flagged or tag:inbox)"
                             :filter-count "tag:github and (tag:github-mention or github-review_requested) and (tag:unread or tag:flagged or tag:inbox)" nil nil)
                            notmuch-hello-insert-saved-searches
                            notmuch-hello-insert-recent-searches
                            notmuch-hello-insert-alltags
                            notmuch-hello-insert-footer))
  :config
  (progn
    (set-face-attribute 'notmuch-message-summary-face
                        nil
                        :box '(:line-width 2 :style released-button)
                        :background nil)))

(provide 'rs-notmuch)
;;; rs-notmuch.el ends here
