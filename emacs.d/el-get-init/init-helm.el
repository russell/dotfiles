;;; Code:

(require 'helm)
(require 'helm-match-plugin)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h a") 'helm-apropos)

(define-minor-mode ido-helm-mode
  "Advices for ido-mode."
  nil nil nil :global t
  (if ido-helm-mode
      (progn
        (ad-enable-regexp "^ido-hacks-")
        (global-set-key (kbd "M-x") 'helm-M-x))
    (global-set-key (kbd "M-x") 'execute-extended-command)
    (ad-disable-regexp "^ido-hacks-"))
  (ad-activate-regexp "^ido-hacks-"))

(ido-helm-mode)

(custom-set-variables
 '(helm-ff-tramp-not-fancy t)
 '(helm-ff-skip-boring-files t)
 '(helm-boring-file-regexp-list
   '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "~$"
    "\\.so$" "\\.a$" "\\.elc$" "\\.fas$" "\\.fasl$" "\\.pyc$" "\\.pyo$"))
 '(helm-boring-buffer-regexp-list
   '("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*tramp" "\\*Minibuf" "\\*epc")))

(eval-after-load 'helm-apt
  '(progn
     (require 'apt-utils)
     (defalias 'helm-apt-cache-show
       (lambda (package)
         (apt-utils-show-package-1 package t nil)))))

(defun helm-backward-kill (arg)
  "Helm backward kill word."
  (interactive "p")
  (when (helm-alive-p)
    (subword-backward-kill arg)))

(define-key helm-map (kbd "C-w") 'helm-backward-kill)

(provide 'init-helm)

;;; init-helm.el ends here
