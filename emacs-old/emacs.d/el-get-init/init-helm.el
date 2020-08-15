
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package helm
  :bind
  ("C-x b" . rs/buffers-list)
  :config

  (use-package helm-files)
  (use-package helm-buffers)

  (defun rs/buffers-list ()
    "Preconfigured `helm' to list buffers."
    (interactive)
    (let ((helm-ff-transformer-show-only-basename nil))
      (unless helm-source-buffers-list
        (setq helm-source-buffers-list
              (helm-make-source "Buffers" 'helm-source-buffers)))
      (helm :sources helm-mini-default-sources
            :buffer "*helm rs/buffers*"
            :keymap helm-buffer-map
            :truncate-lines t)))

  (defun rs/helm-backward-kill (arg)
    "Helm backward kill word."
    (interactive "p")
    (when (helm-alive-p)
      (subword-backward-kill arg)))

  (define-key helm-map (kbd "C-w") 'rs/helm-backward-kill))

(use-package helm-buffers
  :defer t
  :config
  (setq helm-boring-buffer-regexp-list
        '("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*tramp" "\\*Minibuf" "\\*epc")))

(use-package helm-command
  :bind
  ("M-x" . helm-M-x))

(use-package helm-imenu
  :bind
  ("C-x C-i" . helm-imenu))

(use-package helm-ring
  :bind
  ("M-y" . helm-show-kill-ring))

(use-package helm-files
  :bind
  ("C-x C-f" . helm-find-files)
  :config
  (setq helm-ff-skip-boring-files t)
  (setq helm-ff-file-name-history-use-recentf t)
  (setq helm-boring-file-regexp-list
  '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "~$"
    "\\.so$" "\\.a$" "\\.elc$" "\\.fas$" "\\.fasl$" "\\.pyc$" "\\.pyo$")))

(use-package helm-elisp
  :bind
  ("C-h a" . helm-apropos)
  ("C-h f" . helm-apropos)
  ("C-h r" . helm-info-emacs)
  ("C-h C-l" . helm-locate-library))

(use-package helm-tags
  :defer t
  :init
  (substitute-key-definition 'find-tag 'helm-etags-select global-map))


(use-package helm-apt
  :defer t
  :config
  (require 'apt-utils)
  (defalias 'helm-apt-cache-show
    (lambda (package)
      (apt-utils-show-package-1 package t nil))))

(provide 'init-helm)

;;; init-helm.el ends here
