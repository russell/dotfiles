;;; Code:

(require 'helm)
(require 'helm-files)
(require 'helm-match-plugin)
(require 'helm-misc)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'rs/buffers-list)
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

(setq helm-ff-skip-boring-files t)
(setq helm-boring-file-regexp-list
  '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "~$"
    "\\.so$" "\\.a$" "\\.elc$" "\\.fas$" "\\.fasl$" "\\.pyc$" "\\.pyo$"))
(setq helm-boring-buffer-regexp-list
  '("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*tramp" "\\*Minibuf" "\\*epc"))

(eval-after-load 'helm-apt
  '(progn
     (require 'apt-utils)
     (defalias 'helm-apt-cache-show
       (lambda (package)
         (apt-utils-show-package-1 package t nil)))))


(defun rs/buffers-list ()
  "Preconfigured `helm' to list buffers."
  (interactive)
  (let ((helm-ff-transformer-show-only-basename nil))
    (helm :sources helm-mini-default-sources
          :buffer "*helm rs/buffers*"
          :keymap helm-buffer-map
          :truncate-lines t)))


(defun helm-backward-kill (arg)
  "Helm backward kill word."
  (interactive "p")
  (when (helm-alive-p)
    (subword-backward-kill arg)))

(define-key helm-map (kbd "C-w") 'helm-backward-kill)

(provide 'init-helm)

;;; init-helm.el ends here
