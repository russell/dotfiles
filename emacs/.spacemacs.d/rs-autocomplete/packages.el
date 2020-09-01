;;; packages.el --- rs-autocomplete layer packages file for Spacemacs.
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

(defconst rs-autocomplete-packages
  '(company
    auto-complete))

(defun rs-autocomplete/post-init-company ()
  (use-package company
    :config
    (progn
      (setq company-dabbrev-char-regexp "[a-z-_'/]"))

    ))

(defun rs-autocomplete/post-init-auto-complete ()
  (message "ran init")
  (use-package auto-complete
    :init
    (progn
      (setq tab-always-indent t)
      )
    ))

;;; packages.el ends here
