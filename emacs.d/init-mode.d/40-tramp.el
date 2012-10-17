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
  (find-alternate-file
   (concat "/sudo:root@localhost:"
	   (buffer-file-name (current-buffer)))))

(require 'tramp)
;; CCC grok LOCKNAME
(defun tramp-sh-handle-write-region
  (start end filename &optional append visit lockname confirm)
  "Like `write-region' for Tramp files."
  (setq filename (expand-file-name filename))
  (with-parsed-tramp-file-name filename nil
    ;; Following part commented out because we don't know what to do about
    ;; file locking, and it does not appear to be a problem to ignore it.
    ;; Ange-ftp ignores it, too.
    ;;  (when (and lockname (stringp lockname))
    ;;    (setq lockname (expand-file-name lockname)))
    ;;  (unless (or (eq lockname nil)
    ;;              (string= lockname filename))
    ;;    (error
    ;;     "tramp-sh-handle-write-region: LOCKNAME must be nil or equal FILENAME"))

    ;; XEmacs takes a coding system as the seventh argument, not `confirm'.
    (when (and (not (featurep 'xemacs)) confirm (file-exists-p filename))
      (unless (y-or-n-p (format "File %s exists; overwrite anyway? " filename))
	(tramp-error v 'file-error "File not overwritten")))

    (let ((uid (or (nth 2 (tramp-compat-file-attributes filename 'integer))
		   (tramp-get-remote-uid v 'integer)))
	  (gid (or (nth 3 (tramp-compat-file-attributes filename 'integer))
		   (tramp-get-remote-gid v 'integer))))

      (if (and (tramp-local-host-p v)
	       ;; `file-writable-p' calls `file-expand-file-name'.  We
	       ;; cannot use `tramp-run-real-handler' therefore.
	       (let (file-name-handler-alist)
		 (and
		  (file-writable-p (file-name-directory localname))
		  (or (file-directory-p localname)
		      (file-writable-p localname)))))
	  ;; Short track: if we are on the local host, we can run directly.
	  (tramp-run-real-handler
	   'write-region
	   (list start end localname append 'no-message lockname confirm))

	(let* ((modes (save-excursion (tramp-default-file-modes filename)))
	       ;; We use this to save the value of
	       ;; `last-coding-system-used' after writing the tmp
	       ;; file.  At the end of the function, we set
	       ;; `last-coding-system-used' to this saved value.  This
	       ;; way, any intermediary coding systems used while
	       ;; talking to the remote shell or suchlike won't hose
	       ;; this variable.  This approach was snarfed from
	       ;; ange-ftp.el.
	       coding-system-used
	       ;; Write region into a tmp file.  This isn't really
	       ;; needed if we use an encoding function, but currently
	       ;; we use it always because this makes the logic
	       ;; simpler.  We must also set `temporary-file-directory',
	       ;; because it could point to a remote directory.
	       (temporary-file-directory
		(tramp-compat-temporary-file-directory))
	       (tmpfile (or tramp-temp-buffer-file-name
			    (tramp-compat-make-temp-file filename))))

	  ;; If `append' is non-nil, we copy the file locally, and let
	  ;; the native `write-region' implementation do the job.
	  (when append (copy-file filename tmpfile 'ok))

	  ;; We say `no-message' here because we don't want the
	  ;; visited file modtime data to be clobbered from the temp
	  ;; file.  We call `set-visited-file-modtime' ourselves later
	  ;; on.  We must ensure that `file-coding-system-alist'
	  ;; matches `tmpfile'.
	  (let (file-name-handler-alist
		(file-coding-system-alist
		 (tramp-find-file-name-coding-system-alist filename tmpfile)))
	    (condition-case err
		(tramp-run-real-handler
		 'write-region
		 (list start end tmpfile append 'no-message lockname confirm))
	      ((error quit)
	       (setq tramp-temp-buffer-file-name nil)
	       (delete-file tmpfile)
	       (signal (car err) (cdr err))))

	    ;; Now, `last-coding-system-used' has the right value.  Remember it.
	    (when (boundp 'last-coding-system-used)
	      (setq coding-system-used
		    (symbol-value 'last-coding-system-used))))

	  ;; The permissions of the temporary file should be set.  If
	  ;; filename does not exist (eq modes nil) it has been
	  ;; renamed to the backup file.  This case `save-buffer'
	  ;; handles permissions.
	  ;; Ensure that it is still readable.
	  (when modes
	    (set-file-modes
	     tmpfile
	     (logior (or modes 0) (tramp-compat-octal-to-decimal "0400"))))

	  ;; This is a bit lengthy due to the different methods
	  ;; possible for file transfer.  First, we check whether the
	  ;; method uses an rcp program.  If so, we call it.
	  ;; Otherwise, both encoding and decoding command must be
	  ;; specified.  However, if the method _also_ specifies an
	  ;; encoding function, then that is used for encoding the
	  ;; contents of the tmp file.
	  (let* ((size (nth 7 (file-attributes tmpfile)))
		 (rem-dec (tramp-get-inline-coding v "remote-decoding" size))
		 (loc-enc (tramp-get-inline-coding v "local-encoding" size)))
	    (cond
	     ;; `copy-file' handles direct copy and out-of-band methods.
	     ((or (tramp-local-host-p v)
		  (tramp-method-out-of-band-p v size))
	      (if (and (not (stringp start))
		       (= (or end (point-max)) (point-max))
		       (= (or start (point-min)) (point-min))
		       (tramp-get-method-parameter
			method 'tramp-copy-keep-tmpfile))
		  (progn
		    (setq tramp-temp-buffer-file-name tmpfile)
		    (condition-case err
			;; We keep the local file for performance
			;; reasons, useful for "rsync".
			(copy-file tmpfile filename t)
		      ((error quit)
		       (setq tramp-temp-buffer-file-name nil)
		       (delete-file tmpfile)
		       (signal (car err) (cdr err)))))
		(setq tramp-temp-buffer-file-name nil)
		;; Don't rename, in order to keep context in SELinux.
		(unwind-protect
		    (copy-file tmpfile filename t)
		  (delete-file tmpfile))))

	     ;; Use inline file transfer.
	     (rem-dec
	      ;; Encode tmpfile.
	      (unwind-protect
		  (with-temp-buffer
		    (set-buffer-multibyte nil)
		    ;; Use encoding function or command.
		    (if (functionp loc-enc)
			(tramp-with-progress-reporter
			    v 3 (format "Encoding region using function `%s'"
					loc-enc)
			  (let ((coding-system-for-read 'binary))
			    (insert-file-contents-literally tmpfile))
			  ;; The following `let' is a workaround for the
			  ;; base64.el that comes with pgnus-0.84.  If
			  ;; both of the following conditions are
			  ;; satisfied, it tries to write to a local
			  ;; file in default-directory, but at this
			  ;; point, default-directory is remote.
			  ;; (`call-process-region' can't write to
			  ;; remote files, it seems.)  The file in
			  ;; question is a tmp file anyway.
			  (let ((default-directory
				  (tramp-compat-temporary-file-directory)))
			    (funcall loc-enc (point-min) (point-max))))

		      (tramp-with-progress-reporter
			  v 3 (format "Encoding region using command `%s'"
				      loc-enc)
			(unless (zerop (tramp-call-local-coding-command
					loc-enc tmpfile t))
			  (tramp-error
			   v 'file-error
			   (concat "Cannot write to `%s', "
				   "local encoding command `%s' failed")
			   filename loc-enc))))

		    ;; Send buffer into remote decoding command which
		    ;; writes to remote file.  Because this happens on
		    ;; the remote host, we cannot use the function.
		    (tramp-with-progress-reporter
			v 3
			(format "Decoding region into remote file %s" filename)
		      (goto-char (point-max))
		      (unless (bolp) (newline))
		      (tramp-send-command
		       v
		       (format
			(concat rem-dec " <<'EOF'\n%sEOF")
			(tramp-shell-quote-argument localname)
			(buffer-string)))
		      (tramp-barf-unless-okay
		       v nil
		       "Couldn't write region to `%s', decode using `%s' failed"
		       filename rem-dec)
		      ;; When `file-precious-flag' is set, the region is
		      ;; written to a temporary file.  Check that the
		      ;; checksum is equal to that from the local tmpfile.
		      (when file-precious-flag
			(erase-buffer)
			(and
			 ;; cksum runs locally, if possible.
			 (zerop (tramp-compat-call-process "cksum" tmpfile t))
			 ;; cksum runs remotely.
			 (tramp-send-command-and-check
			  v
			  (format
			   "cksum <%s" (tramp-shell-quote-argument localname)))
			 ;; ... they are different.
			 (not
			  (string-equal
			   (buffer-string)
			   (with-current-buffer (tramp-get-buffer v)
			     (buffer-string))))
			 (tramp-error
			  v 'file-error
			  (concat "Couldn't write region to `%s',"
				  " decode using `%s' failed")
			  filename rem-dec)))))

		;; Save exit.
		(delete-file tmpfile)))

	     ;; That's not expected.
	     (t
	      (tramp-error
	       v 'file-error
	       (concat "Method `%s' should specify both encoding and "
		       "decoding command or an rcp program")
	       method))))

	  ;; Make `last-coding-system-used' have the right value.
	  (when coding-system-used
	    (set 'last-coding-system-used coding-system-used))))

      (tramp-flush-file-property v (file-name-directory localname))
      (tramp-flush-file-property v localname)

      ;; We must protect `last-coding-system-used', now we have set it
      ;; to its correct value.
      (let (last-coding-system-used (need-chown t))
	;; Set file modification time.
	(when (or (eq visit t) (stringp visit))
          (let ((file-attr (file-attributes filename)))
            (set-visited-file-modtime
             ;; We must pass modtime explicitly, because filename can
             ;; be different from (buffer-file-name), f.e. if
             ;; `file-precious-flag' is set.
             (nth 5 file-attr))
            (when (and (eql (nth 2 file-attr) uid)
                       (eql (nth 3 file-attr) gid))
              (setq need-chown nil))))

	;; Set the ownership.
        (when need-chown
          (tramp-set-file-uid-gid filename uid gid))
	(when (or (eq visit t) (null visit) (stringp visit))
	  (tramp-message v 0 "Wrote %s" filename))
	(run-hooks 'tramp-handle-write-region-hook)))))
