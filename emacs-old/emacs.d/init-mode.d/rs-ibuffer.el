
;;; Code:

(eval-when-compile
  (require 'use-package))


(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  :config
 (define-key ibuffer-mode-map "\C-x\C-f" 'ibuffer-ido-find-file)

 (use-package ibuf-ext
   :config
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

   (add-hook 'ibuffer-mode-hook
	  (lambda ()
        (ibuffer-do-sort-by-alphabetic)))))

(defun ibuffer-ido-find-file ()
  "Like `ido-find-file', but default to the directory of the buffer at point."
  (interactive
   (let ((default-directory
           (let ((buf (ibuffer-current-buffer)))
             (if (buffer-live-p buf)
                 (with-current-buffer buf
                   default-directory)
               default-directory))))
     (call-interactively 'helm-find-files))))

(provide 'rs-ibuffer)
;;; rs-ibuffer.el ends here
