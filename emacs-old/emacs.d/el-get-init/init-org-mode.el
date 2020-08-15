
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package org
  :defer t
  :config
  (setq org-agenda-files (quote ("~/org/")))
  (setq org-directory "~/org/")
  (setq org-hide-leading-stars t)
  (setq org-modules (quote (org-bibtex org-docview org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-toc org-wikinodes)))
  (setq org-startup-folded (quote content))
  (setq org-tag-persistent-alist (quote ((:startgroup) ("WORK" . 119) ("HOME" . 104) (:endgroup) ("READING" . 114) ("COMPUTER" . 99))))
  (setq org-todo-keywords (quote ((type "TODO(t)" "STARTED(s)" "WAITING(w)" "APPT(a)" "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)"))))
  (setq org-babel-load-languages (quote ((emacs-lisp . t) (sh . t) (python . t))))
  (setq org-src-fontify-natively t)
  (setq org-return-follows-link t)
  (setq org-use-sub-superscripts '{})
  (setq org-imenu-depth 3)
  (add-hook 'org-mime-html-hook 'rs/org-html-mime-code-blocks)


  ;; Delete whitespace on save.
  (add-hook 'org-mode-hook
            '(lambda ()
               (add-hook 'write-contents-functions
                         'delete-trailing-whitespace)))

  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook 'artbollocks-mode))

(use-package ox
  :defer t
  :config
  (setq org-export-async-init-file "~/.emacs.d/init-org-export.el"))

(use-package ob-shell
  :defer t
  :config
  (setq org-babel-sh-command "bash"))

(use-package org-mobile
  :defer t
  :config
  (setq org-mobile-directory "~/public_html/org")
  (setq org-mobile-inbox-for-pull "~/org/flagged.org"))


(global-set-key [f1]
                (lambda ()
                  (interactive)
                  (helm-find-files-1 (expand-file-name "~/org/"))))


(defun rs/org-html-mime-code-blocks ()
            (org-mime-change-element-style
             "pre" (format "color: %s; background-color: %s; padding: 0.5em;"
                           "#E6E1DC" "#232323")))


(use-package org-passwords
  :defer t
  :config
  (setq org-passwords-file "~/org/passwords.org.gpg")
  (setq org-passwords-random-words-dictionary "/etc/dictionaries-common/words")
  (define-key org-passwords-mode-map
    (kbd "C-c u")
    'org-passwords-copy-username)
  (define-key org-passwords-mode-map
    (kbd "C-c p")
    'org-passwords-copy-password)
  (define-key org-passwords-mode-map
    (kbd "C-c o")
    'org-passwords-open-url))


(use-package org-capture
  :defer t
  :config
  (setq org-capture-templates
        '(("P" "New password entry (auto password)" entry
           (file "~/passwords.org.gpg")
           "* %^{Title}
  :PROPERTIES:
  :UPDATED: %(org-insert-time-stamp (current-time) t t)
  :USERNAME: %^{USERNAME}
  :PASSWORD: %(rs/pwgen 1)
  :END:
")
          ("p" "New password entry" entry
           (file "~/passwords.org.gpg")
           "* %^{Title}
  :PROPERTIES:
  :UPDATED: %(org-insert-time-stamp (current-time) t t)
  :USERNAME: %^{USERNAME}
  :PASSWORD: %^{PASSWORD}
  :END:
"))))


(provide 'init-org-mode)
;;; init-org-mode.el ends here
