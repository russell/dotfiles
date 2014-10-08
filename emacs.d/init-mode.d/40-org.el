(setq org-agenda-files (quote ("~/org/")))
(setq org-directory "~/org/")
(setq org-hide-leading-stars t)
(setq org-mobile-directory "~/public_html/org")
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
(setq org-modules (quote (org-bibtex org-docview org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-toc org-wikinodes)))
(setq org-startup-folded (quote content))
(setq org-tag-persistent-alist (quote ((:startgroup) ("WORK" . 119) ("HOME" . 104) (:endgroup) ("READING" . 114) ("COMPUTER" . 99))))
(setq org-todo-keywords (quote ((type "TODO(t)" "STARTED(s)" "WAITING(w)" "APPT(a)" "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)"))))
(setq org-babel-load-languages (quote ((emacs-lisp . t) (sh . t) (python . t))))
(setq org-src-fontify-natively t)
(setq org-return-follows-link t)
(setq org-completion-use-ido t)

;; Org Mode
(defun lconfig-org-mode ()
  (progn
    (auto-fill-mode)
    (flyspell-mode)))

(add-hook 'org-mode-hook
          'lconfig-org-mode)

(add-hook 'org-mode-hook
          'artbollocks-mode)

(global-set-key [f1]
                (lambda ()
                  (interactive)
                  (dired "~/org")))

;; Delete whitespace on save.
(add-hook 'org-mode-hook
          '(lambda ()
             (add-hook 'write-contents-functions
                       '(lambda()
                          (save-excursion
                            (delete-trailing-whitespace))))))
