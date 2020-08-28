;;; packages.el --- rs-gnus layer packages file for Spacemacs.
;;
;; Copyright (c) 2020 Russell Sim
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
;; added to `rs-gnus-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rs-gnus/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rs-gnus/pre-init-PACKAGE' and/or
;;   `rs-gnus/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rs-gnus-packages
  '(
    gnus
    )
  "The list of Lisp packages required by the rs-gnus layer.

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

(defun rs-gnus/init-gnus ()
  (use-package gnus)
  (use-package gnus-cloud
    :config
    (progn

      (defcustom gnus-cloud-epg-encrypt-to nil
        "Recipient(s) used for encrypting files.
May either be a string or a list of strings."
        :group 'gnus-cloud
        :type '(list string))

      (defun gnus-cloud-encode-data ()
        (cond
         ((eq gnus-cloud-storage-method 'base64-gzip)
          (progn
            (call-process-region (point-min) (point-max) "gzip"
                                 t (current-buffer) nil
                                 "-c")
            (base64-encode-region (point-min) (point-max))))

         ((eq gnus-cloud-storage-method 'base64)
          (base64-encode-region (point-min) (point-max)))

         ((eq gnus-cloud-storage-method 'epg)
          (let ((context (epg-make-context 'OpenPGP))
                (recipients
                 (cond
                  ((listp gnus-cloud-epg-encrypt-to) gnus-cloud-epg-encrypt-to)
                  ((stringp gnus-cloud-epg-encrypt-to) (list gnus-cloud-epg-encrypt-to))))
                cipher)
            (setf (epg-context-armor context) t)
            (setf (epg-context-textmode context) t)
            (let ((data (epg-encrypt-string context
                                            (buffer-substring-no-properties
                                             (point-min)
                                             (point-max))
                                            (epg-list-keys context recipients t))))
              (delete-region (point-min) (point-max))
              (insert data))))

         ((null gnus-cloud-storage-method)
          (gnus-message 5 "Leaving cloud data plaintext"))
         (t (gnus-error 1 "Invalid cloud storage method %S"
                        gnus-cloud-storage-method)))))
    )
  )


;;; packages.el ends here
