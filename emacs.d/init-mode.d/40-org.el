(setq org-agenda-files (quote ("~/.deft/")))
(setq org-directory "~/.deft/")
(setq org-hide-leading-stars t)
(setq org-mobile-directory "~/public_html/org")
(setq org-mobile-inbox-for-pull "~/.deft/flagged.org")
(setq org-modules (quote (org-bibtex org-docview org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-toc org-wikinodes)))
(setq org-startup-folded (quote content))
(setq org-tag-persistent-alist (quote ((:startgroup) ("WORK" . 119) ("HOME" . 104) (:endgroup) ("READING" . 114) ("COMPUTER" . 99))))
(setq org-todo-keywords (quote ((type "TODO(t)" "STARTED(s)" "WAITING(w)" "APPT(a)" "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)"))))

; Org Mode
(defun lconfig-org-mode ()
  (progn
    (auto-fill-mode)
    (flyspell-mode)
    (autocommit-setup-save-hook)
    ))
(add-hook 'org-mode-hook 'lconfig-org-mode)

(setq org-completion-use-ido t)
