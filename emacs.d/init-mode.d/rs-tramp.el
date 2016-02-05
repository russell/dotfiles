
;;; Code:

(require 'use-package)

;; TRAMP

(use-package tramp
  :config
  (use-package rs-core)

  (set-default 'tramp-default-proxies-alist '())
  (add-to-list 'tramp-default-proxies-alist
               '(".*home" "\\`root\\'" "/ssh:%h:"))
  (unless (equal rs/hostname "kieran")
    (add-to-list 'tramp-default-proxies-alist
                 '(".*\\.rc\\.nectar\\.org\\.au" nil
                   "/ssh:russell@kieran.dev.rc.nectar.org.au:"))
    (add-to-list 'tramp-default-proxies-alist
                 '("kieran.dev.rc.nectar.org.au" nil nil)))
  (add-to-list 'tramp-default-proxies-alist
               '((regexp-quote (system-name)) nil nil))
  (add-to-list 'tramp-default-proxies-alist
               '((regexp-quote "localhost") nil nil))


  ;; Add global known_hosts file to tramp completion
  (tramp-set-completion-function
   "ssh"
   '((tramp-parse-connection-properties "ssh")
     (tramp-parse-shosts "~/.ssh/known_hosts")
     (tramp-parse-shosts "/etc/ssh/ssh_known_hosts"))))


(defun sudo-edit-current-file ()
  "Reopen the current file using sudo."
  (interactive)
  (let ((position (point)))
    (find-alternate-file
     (if (file-remote-p (buffer-file-name))
         (let ((vec (tramp-dissect-file-name (buffer-file-name))))
           (tramp-make-tramp-file-name
            "sudo"
            (tramp-file-name-user vec)
            (tramp-file-name-host vec)
            (tramp-file-name-localname vec)))
       (concat "/sudo:root@localhost:" (buffer-file-name))))
    (goto-char position)))

(provide 'rs-tramp)
;;; rs-tramp.el ends here
