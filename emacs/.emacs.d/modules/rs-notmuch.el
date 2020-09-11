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

(use-package notmuch
  :bind (:map rs-applications-map
              ("n" . notmuch))
  :init
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
  :config
  (progn
    (set-face-attribute 'notmuch-message-summary-face
                        nil
                        :box '(:line-width 2 :style released-button)
                        :background nil)))

(provide 'rs-notmuch)
;;; rs-notmuch.el ends here
