;;; packages.el --- rs-org layer packages file for Spacemacs.
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
;; added to `rs-org-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rs-org/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rs-org/pre-init-PACKAGE' and/or
;;   `rs-org/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rs-org-packages
  '(org-variable-pitch)
  "The list of Lisp packages required by the rs-org layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun rs-org/init-org-variable-pitch()
  (use-package org-variable-pitch
    :config
    (progn
      (add-to-list 'org-mode-hook 'org-variable-pitch-minor-mode)
      (add-to-list 'org-variable-pitch-fixed-faces 'org-link)
      (setq 'org-variable-pitch-fixed-font "Iosevka Fixed SS11"))
    )
  )

;; (defun rs-org/post-init-org()
;;   (let ((pitch-fixed-faces '(org-block
;;                              org-block-begin-line
;;                              org-block-end-line
;;                              ;; org-code
;;                              ;; org-document-info-keyword
;;                              org-done
;;                              org-formula
;;                              ;; org-meta-line
;;                              ;; org-special-keyword
;;                              font-lock-comment-face
;;                              org-table
;;                              org-todo
;;                              ;; org-verbatim
;;                              shadow
;;                              org-date
;;                              )))
;;     (dolist (face pitch-fixed-faces)
;;       (set-face-attribute face nil :inherit 'fixed-pitch)
;;     ))

;;   )

;;; packages.el ends here
