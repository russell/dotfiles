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
    company-posframe
    auto-complete))

(defun rs-autocomplete/post-init-company ()
  (use-package company
    :config
    (progn
      ;; Discussed here https://github.com/company-mode/company-mode/issues/433
      (setq company-dabbrev-char-regexp "[a-z-_'/]"))
    ))

(defun rs-autocomplete/post-init-auto-complete ()
  (use-package auto-complete
    :init
    (progn
      (setq tab-always-indent t)
      )
    ))

(defun rs-autocomplete/init-company-posframe ()
  (use-package company-posframe
    :hook '(company-mode . company-posframe-mode)))

;;; packages.el ends here
