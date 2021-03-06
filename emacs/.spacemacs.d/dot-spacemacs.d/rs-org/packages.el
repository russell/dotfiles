;;; packages.el --- rs-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2020 Russell Sim
;;
;; Author: Russell Sim <russell.sim@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst rs-org-packages
  '(org-variable-pitch
    org-ql
    org-roam
    org-journal
    deft
    org
    plantuml-mode
    (org-super-links :location (recipe
                                :fetcher github
                                :repo "toshism/org-super-links"))))

(defun rs-org/init-org-variable-pitch()
  (use-package org-variable-pitch
    :config
    (progn
      (add-to-list 'org-mode-hook 'org-variable-pitch-minor-mode)
      (add-to-list 'org-variable-pitch-fixed-faces 'org-link)
      (setq org-variable-pitch-fixed-font "Iosevka Fixed SS11"))
    )
  )

(defun rs-org/post-init-org()
  (use-package org
    :config
    (progn
      (require 'org-id)
      (require 'org-protocol)
      (setq org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))
      (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id
            org-agenda-files '("~/org/")
            org-agenda-include-diary t
            org-outline-path-complete-in-steps nil
            org-refile-use-outline-path 'file
            org-refile-targets '((org-agenda-files :maxlevel . 4))
            org-refile-allow-creating-parent-nodes 'confirm)
      (add-hook 'diary-list-entries-hook 'diary-include-other-diary-files)
      (add-hook 'diary-mark-entries-hook 'diary-mark-included-diary-files)
      (setq org-agenda-custom-commands
            '(("p" "Personal TODOs"
               ((agenda "")
                (tags-todo "+personal+projects")
                (tags-todo "+personal+areas"))
               nil
               ("~/org/todo_personal.html"))
              ("P" "Lost personal TODOS"
               ((agenda "")
                (tags-todo "+personal-projects-areas")))
              ("z" "Zendesk TODOs"
               ((agenda "")
                (tags-todo "+zendesk+projects")
                (tags-todo "+zendesk+areas"))
               nil
               ("~/org/todo_zendesk.html"))
              ("Z" "Lost Zendesk TODOs"
               ((agenda "")
                (tags-todo "+zendesk-projects-areas")))))
      ))


  ;; (let ((pitch-fixed-faces '(org-block
  ;;                            org-block-begin-line
  ;;                            org-block-end-line
  ;;                            ;; org-code
  ;;                            ;; org-document-info-keyword
  ;;                            org-done
  ;;                            org-formula
  ;;                            ;; org-meta-line
  ;;                            ;; org-special-keyword
  ;;                            font-lock-comment-face
  ;;                            org-table
  ;;                            org-todo
  ;;                            ;; org-verbatim
  ;;                            shadow
  ;;                            org-date
  ;;                            )))
  ;;   (dolist (face pitch-fixed-faces)
  ;;     (set-face-attribute face nil :inherit 'fixed-pitch)
  ;;   ))

  )

(defun rs-org/post-init-deft()
  (use-package deft
    :defer t
    :init
    (progn
      (setq deft-directory "~/org/roam"
            deft-recursive t
            deft-use-filename-as-title t
            deft-use-filter-string-for-filename t)
      )
    )
  )

(defun rs-org/post-init-org-journal()
  (use-package org-journal
    :init
    (progn
      (setq org-journal-dir "~/org/roam/journal/"
            org-journal-date-prefix "#+title: "
            org-journal-time-prefix "* "
            org-journal-file-format "%Y-%m-%d.org"
            org-journal-date-format "%A, %d %B %Y")
      (spacemacs/set-leader-keys
        "aojc" 'org-journal-open-current-journal-file))))

(defun rs-org/init-org-super-links()
  (use-package org-super-links
    :defer t
    :init
    (progn
      (require 'org-ql)
      (require 'helm-org-ql)
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "l" 'sl-link
        )
      )
    )
  )

(defun rs-org/init-org-ql()
  (use-package org-ql
    :defer t
    )
  )

(defun rs-org/init-org-roam()
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
                (("C-c n I" . org-roam-insert-immediate)))))

(defun rs-org/post-init-plantuml-mode()
  (use-package plantuml-mode
    :config
    (progn
      (setq org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
            plantuml-jar-path "/usr/share/plantuml/plantuml.jar"))
    )
  )

;;; packages.el ends here
