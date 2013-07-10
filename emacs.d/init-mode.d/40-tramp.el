; TRAMP
(setq password-cache-expiry 1000)
(set-default 'tramp-default-proxies-alist '())
(add-to-list 'tramp-default-proxies-alist
	     '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
	     '("10\\.42\\.33\\.1" nil nil))
(add-to-list 'tramp-default-proxies-alist
	     '("\\.rc\\.nectar\\.org\\.au" nil "/ssh:root@ra-np.melbourne.nectar.org.au:"))
(add-to-list 'tramp-default-proxies-alist
	     '("115\\.146\\.83" nil nil))
(add-to-list 'tramp-default-proxies-alist
	     '("115\\.146\\.90" nil nil))
(add-to-list 'tramp-default-proxies-alist
	     '("115\\.146\\.92" nil nil))
(add-to-list 'tramp-default-proxies-alist
	     '("115\\.146\\.93" nil nil))
(add-to-list 'tramp-default-proxies-alist
	     '("115\\.146\\.94" nil nil))
(add-to-list 'tramp-default-proxies-alist
	     '("115\\.146\\.95" nil nil))
(add-to-list 'tramp-default-proxies-alist
	     '("10\\.42\\.33\\.1" nil nil))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote "localhost") nil nil))

;; Sudo
(defun sudo-edit-current-file ()
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

(require 'tramp)
