;;; packages.el --- rs-shell layer packages file for Spacemacs.
;;
;; Copyright (c) 2020 Russell Sim
;;
;; Author: Russell Sim <russell.sim@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst rs-shell-packages
  '(bash-completion
    fish-completion
    esh-autosuggest
    (eshell :location built-in)
    ))

(defun rs-shell/init-esh-autosuggest ()
  (use-package esh-autosuggest
    :hook (eshell-mode . esh-autosuggest-mode)
    :after eshell
    )
  )

(defun rs-shell/init-bash-completion ()
  (use-package bash-completion
    :after eshell
    )
  )

(defun rs-shell/init-fish-completion ()
  (use-package fish-completion
    :after eshell
    :config
    (when (and (executable-find "fish")
               (require 'fish-completion nil t))
      (global-fish-completion-mode))
    )
  )

(defun rs-shell/post-init-eshell ()
      (setq eshell-destroy-buffer-when-process-dies t)
      (setq eshell-modules-list
            '(eshell-alias
              eshell-banner
              eshell-basic
              eshell-cmpl
              eshell-dirs
              eshell-glob
              eshell-hist
              eshell-ls
              eshell-pred
              eshell-prompt
              eshell-script
              eshell-smart
              eshell-term
              eshell-tramp
              eshell-unix
              eshell-xtra))
      )
;;; packages.el ends here
