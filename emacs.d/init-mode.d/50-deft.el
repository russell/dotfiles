(setq deft-auto-save-interval 30.0)


;; Automatically add, commit, and push when files change.
;; https://gist.github.com/449668 && https://gist.github.com/397971
(defvar autocommit-dir-set '()
  "Set of directories for which there is a pending timer job")

(defun autocommit-schedule-commit (dn)
  "Schedule an autocommit (and push) if one is not already scheduled for the given dir."
  (if (null (member dn autocommit-dir-set))
      (progn
       (run-with-idle-timer
        10 nil
        (lambda (dn)
          (setq autocommit-dir-set (remove dn autocommit-dir-set))
          (message (concat "Committing org files in " dn))
          (shell-command (concat "cd " dn " && git commit -m 'Updated org files.'"))
          (shell-command (concat "cd " dn " && git push & true")))
        dn)
       (setq autocommit-dir-set (cons dn autocommit-dir-set)))))

(defun autocommit-schedule-pull (dn)
  "Schedule a pull if one is not already scheduled for the given dir."
  (if (null (member dn autocommit-dir-set))
      (progn
       (run-with-idle-timer
        10 nil
        (lambda (dn)
          (setq autocommit-dir-set (remove dn autocommit-dir-set))
          (shell-command (concat "cd " dn " && git pull & true")))
        dn)
       (setq autocommit-dir-set (cons dn autocommit-dir-set)))))

(defun autocommit-after-save-hook ()
  "After-save-hook to 'git add' the modified file and schedule a commit and push in the idle loop."
  (let ((fn (buffer-file-name)))
    (message "git adding %s" fn)
    (shell-command (mapconcat 'shell-quote-argument (list "git" "add" fn) " "))
    (autocommit-schedule-commit (file-name-directory fn))))

(defun autocommit-setup-save-hook ()
  "Set up the autocommit save hook for the current file."
  (interactive)
  (message "Set up autocommit save hook for this buffer.")
  (add-hook 'after-save-hook 'autocommit-after-save-hook nil t))

;;
;; Integration
;;

(defun dustin-visiting-a-file ()
  (let* ((fn (buffer-file-name))
         (dn (file-name-directory fn)))
    (if (equal dn (expand-file-name "~/org/"))
        (progn
          (message "Setting up local hook for %s (in %s)"
                   (file-name-nondirectory fn) dn)
          (autocommit-setup-save-hook)))))

;;(add-hook 'find-file-hook 'dustin-visiting-a-file)


;; Deft mode hook
(defun deft-sync-pull ()
  (let* ((dn deft-directory))
    (progn
      (message "schedualed pull for %s" dn)
      (autocommit-schedule-pull dn))))

(add-hook 'deft-mode-hook 'deft-sync-pull)
