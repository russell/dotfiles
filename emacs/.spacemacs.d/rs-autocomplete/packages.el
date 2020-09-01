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

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `rs-autocomplete-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rs-autocomplete/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rs-autocomplete/pre-init-PACKAGE' and/or
;;   `rs-autocomplete/post-init-PACKAGE' to customize the package as it is loaded.

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
