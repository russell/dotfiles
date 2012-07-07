;; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("erc" (mode . erc-mode))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*.*\\*$")
			 (name . "^\\*Messages\\*$")))
	       ("org" (mode . org-mode))
	       ("gnus" (or
			(mode . message-mode)
			(mode . mail-mode)
			(mode . gnus-group-mode)
			(mode . gnus-summary-mode)
			(mode . gnus-article-mode)
			(name . "^\\.newsrc-dribble")))))))

(setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 28 28 :left :elide)
              " "
              (size 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-vc-set-filter-groups-by-vc-root)
        (ibuffer-do-sort-by-alphabetic)))

(defun ibuffer-ido-find-file ()
  "Like `ido-find-file', but default to the directory of the buffer at point."
  (interactive
   (let ((default-directory (let ((buf (ibuffer-current-buffer)))
			      (if (buffer-live-p buf)
				  (with-current-buffer buf
				    default-directory)
				default-directory))))
     (ido-find-file-in-dir default-directory))))

(define-key ibuffer-mode-map "\C-x\C-f" 'ibuffer-ido-find-file)
