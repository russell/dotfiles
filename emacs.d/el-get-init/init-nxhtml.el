
;;; Code:

(eval-when-compile
  (require 'use-package))

;; Work Around nxhtml bug.
;; https://gist.github.com/tkf/3951163
(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version 1))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

(use-package nxhtml
  :init
  ; XML Modes
  (add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

  (add-to-list 'auto-mode-alist '("\\.html$" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.zpt$" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.pt$" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.zcml$" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.xhtml$" . nxml-mode))
  :config
  (eval-after-load "nxml-mode"
    '(progn
       (add-hook 'nxml-mode-hook 'flyspell-mode)
       ;; diff hl mode
       (add-hook 'nxml-mode-hook 'diff-hl-mode)

       ;; Delete whitespace on save.
       (add-hook 'nxml-mode-hook
                 '(lambda ()
                    (add-hook 'write-contents-functions
                              'delete-trailing-whitespace))))))

(provide 'init-nxhtml)
;;; init-nxhtml.el ends here
