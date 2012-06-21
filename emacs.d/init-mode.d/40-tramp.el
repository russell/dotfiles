; TRAMP
(setq password-cache-expiry 1000)
(set-default 'tramp-default-proxies-alist '())
(add-to-list 'tramp-default-proxies-alist
	     '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
	     '("10\\.42\\.33\\.1" nil nil))
(add-to-list 'tramp-default-proxies-alist
	     '("\\.nectar\\.org\\.au" nil nil))
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
  (find-alternate-file
   (concat "/sudo:root@localhost:"
	   (buffer-file-name (current-buffer)))))
