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

(defun rs-notmuch/post-init-notmuch ()
  (use-package notmuch
    :config
    (progn
     (set-face-attribute 'notmuch-message-summary-face
                         nil :box '(:line-width 1 :color "grey75" :style released-button)))
    )

  (setq
   notmuch-hello-tag-list-make-query "tag:unread"
   notmuch-show-logo nil
   notmuch-fcc-dirs nil
   shr-use-colors nil
   notmuch-tag-formats '(("unread"
                          (all-the-icons-material "email" :height 0.9 :v-adjust -0.1))
                         ("flagged"
                          (all-the-icons-material "star" :height 0.9 :v-adjust -0.1)))
   notmuch-hello-sections '(notmuch-hello-insert-header
                            notmuch-hello-insert-search
                            (notmuch-hello-insert-tags-section
                             "Inbox"
                             :filter "tag:inbox and not tag:github"
                             :filter-count "tag:inbox and tag:unread and not tag:github" nil nil)
                            (notmuch-hello-insert-tags-section
                             "Github Reviews"
                             :filter "tag:github and (tag:github-mention or github-review_requested) and tag:unread"
                             :filter-count "tag:github and (tag:github-mention or github-review_requested) and tag:unread" nil nil)
                            notmuch-hello-insert-saved-searches
                            notmuch-hello-insert-recent-searches
                            notmuch-hello-insert-alltags
                            notmuch-hello-insert-footer)
   )
  )
;;; packages.el ends here
