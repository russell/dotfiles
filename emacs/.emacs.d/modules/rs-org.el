;;; rs-org.el --- Org Mode                           -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Russell Sim

;; Author: Russell Sim <russell@mowgli>
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

(prelude-require-packages '(org-variable-pitch
                            org-ql
                            org-roam
                            org-journal
                            org-gcal
                            helm-org
                            helm-org-rifle
                            plantuml-mode))


(rs-require-package '(org-super-links :fetcher github
                                      :repo "toshism/org-super-links"))
(use-package org-gcal
  :hook
  (org-agenda-mode-hook . org-gcal-sync))

(use-package org-variable-pitch
  :hook
  (org-mode-hook . org-variable-pitch-minor-mode)
  :config
  (progn
    (add-to-list 'org-variable-pitch-fixed-faces 'org-link)
    (setq org-variable-pitch-fixed-font "Iosevka Fixed SS11"))
  )

(use-package helm-org-rifle
  :bind (:map rs-applications-map
              ("o r" . 'helm-org-rifle-org-directory)))

(use-package diary-lib
  :defer t
  :config
  (add-hook 'diary-list-entries-hook 'diary-include-other-diary-files)
  (add-hook 'diary-mark-entries-hook 'diary-mark-included-diary-files))

(use-package org
  :bind
  (:map rs-applications-map
        ("a" . org-agenda))
  :config
  (progn
      (setq org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)"))
            org-src-fontify-natively t
            org-src-tab-acts-natively t
            org-modules '(ol-bbdb
                          ol-bibtex
                          org-crypt
                          ol-docview
                          ol-eww
                          ol-gnus
                          org-habit
                          org-id
                          org-protocol
                          ol-info
                          ol-irc
                          ol-mhe
                          ol-rmail
                          org-tempo
                          ol-w3m
                          ol-eshell
                          ol-notmuch
                          org-toc)
            org-agenda-files '("~/org/")
            org-outline-path-complete-in-steps nil
            org-refile-use-outline-path 'file
            org-refile-targets '((org-agenda-files :maxlevel . 4))
            org-refile-allow-creating-parent-nodes 'confirm)
      (setq org-agenda-custom-commands
            '(("p" "Personal TODOs"
               ((agenda "" ((org-agenda-files '("~/org/todo_personal.org"
                                                "~/org/calendar_personal.org"
                                                "~/org/calendar_cph_events.org"
                                                "~/org/calendar_garmin.org"))))
                (tags-todo "+personal+projects")
                (tags-todo "+personal+areas"))
               nil
               ("~/org/todo_personal.html"))
              ("P" "Lost personal TODOS"
               ((agenda "" ((org-agenda-files '("~/org/todo_personal.org"
                                                "~/org/calendar_personal.org"
                                                "~/org/calendar_cph_events.org"
                                                "~/org/calendar_garmin.org"))))
                (tags-todo "+personal-projects-areas")))
              ("z" "Zendesk TODOs"
               ((agenda "" ((org-agenda-span 3)
                            (org-agenda-files '("~/org/todo_zendesk.org"
                                                "~/org/calendar_zendesk.org"
                                                "~/org/calendar_zendesk_comet.org"))))
                (tags-todo "+zendesk+projects")
                (tags-todo "+zendesk+areas"))
               nil
               ("~/org/todo_zendesk.html"))
              ("Z" "Lost Zendesk TODOs"
               ((agenda "" ((org-agenda-span 3)
                            (org-agenda-files '("~/org/todo_zendesk.org"
                                                "~/org/calendar_zendesk.org"
                                                "~/org/calendar_zendesk_comet.org"))))
                (tags-todo "+zendesk-projects-areas")))))
      ))

(use-package org-agenda)

(use-package org-id
  :defer t
  :config
  (progn
    (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)))

(use-package org-journal
  :config
  (progn
    (setq org-journal-dir "~/org/roam/journal/"
          org-journal-date-prefix "#+title: "
          org-journal-time-prefix "* "
          org-journal-file-format "%Y-%m-%d.org"
          org-journal-date-format "%A, %d %B %Y")
    )
  :bind (:map rs-applications-map
              ("j j" . org-journal-new-entry)
              ("j c" . org-journal-open-current-journal-file)))

(use-package org-super-links
  :defer t
  :init
  (progn
    (require 'org-ql)
    (require 'helm-org-ql)
    )
  :bind (:map org-mode-map ("C-c C-S-L" . sl-link)))

(use-package org-roam
    :ensure t
    :hook
    (after-init . org-roam-mode)
    :custom
    ((org-roam-directory "~/org/roam"))
    :config
    (progn
      (require 'org-roam-capture)
      (require 'org-roam-protocol)
      (setq org-roam-capture-ref-templates
            '(("r" "ref" plain (function org-roam-capture--get-point)
               "%i%?"
               :file-name "${slug}"
               :head "#+title: ${title}\n#+roam_key: ${ref}\n"
               :unnarrowed t)))
      (setq org-capture-templates
            '(
              ("d" "default" plain (function org-roam--capture-get-point)
               "%?"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+title: ${title}\n"
               :unnarrowed t)
              ("t" "personal TODO" entry
               (file+headline "~/org/todo.org" "Inbox"))
              ("w" "work TODO" entry
               (file+headline "~/org/todo_zendesk.org" "Inbox"))
              ("j" "journal note" entry
               (file org-journal--get-entry-path)
               "* Event: %?\n\n  %i\n\n  From: %a"
               :empty-lines 1)
              ("p" "protocol:personal - capture a link and quote" entry (function rs/goto-current-journal)
               "* %(format-time-string org-journal-time-format)%^{Title} :personal:\n   [[%:link][%:description]]\n\n   #+BEGIN_QUOTE\n   %i\n   #+END_QUOTE\n\n%?"
               :head "#+title: ${title}\n"
               :empty-lines 1)
              ("P" "protocol:personal - capture a link" entry (function rs/goto-current-journal)
               "* %(format-time-string org-journal-time-format)%^{Title} :personal:\n   [[%:link][%:description]]\n\n%?"
               :head "#+title: $(format-time-string org-journal-date-format)\n"
               :empty-lines 1)
              ("z" "protocol:zendesk - capture a link and quote" entry (function rs/goto-current-journal)
               "* %(format-time-string org-journal-time-format)%^{Title} :zendesk:\n   [[%:link][%:description]]\n\n   #+BEGIN_QUOTE\n   %i\n   #+END_QUOTE\n\n%?"
               :head "#+title: ${title}\n"
               :empty-lines 1)
              ("Z" "protocol:zendesk - capture a link" entry (function rs/goto-current-journal)
               "* %(format-time-string org-journal-time-format)%^{Title} :zendesk:\n   [[%:link][%:description]]\n\n%?"
               :head "#+title: $(format-time-string org-journal-date-format)\n"
               :empty-lines 1))))
    :bind (:map org-roam-mode-map
                (("C-c n l" . org-roam)
                 ("C-c n f" . org-roam-find-file)
                 ("C-c n g" . org-roam-graph-show))
                :map org-mode-map
                (("C-c n i" . org-roam-insert))
                (("C-c n I" . org-roam-insert-immediate))))

(use-package plantuml-mode
  :config
  (progn
    (setq org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
          plantuml-jar-path "/usr/share/plantuml/plantuml.jar"))
  )

(defun rs/goto-current-journal()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))



(provide 'rs-org)
;;; rs-org.el ends here
