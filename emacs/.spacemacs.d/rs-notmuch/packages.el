;;; packages.el --- rs-notmuch layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Russell Sim <russell@sleipnir>
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
;; added to `rs-notmuch-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rs-notmuch/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rs-notmuch/pre-init-PACKAGE' and/or
;;   `rs-notmuch/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rs-notmuch-packages
  '(notmuch)
  "The list of Lisp packages required by the rs-notmuch layer.

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

(defun rs-notmuch/find-folder-searches (directory)
  "List the mail folder directories"
  (mapcar
   (lambda (folder)
     (let ((folder (substring folder (length directory) -4)))
       (list
        :name folder
        :query (concat "folder:\"" folder "\"")
        )
       )
     )
   (directory-files-recursively directory "^cur$" t)))

(defun rs-notmuch/setup-saved-searches ()
  (mapc (lambda (saved-search)
          (add-to-list 'notmuch-saved-searches 
                       saved-search)
          )
        (rs-notmuch/find-folder-searches "~/Mail/gmail/")
        ))


(defun rs-notmuch/init-notmuch ()

  )
;;; packages.el ends here