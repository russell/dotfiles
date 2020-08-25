;;; packages.el --- rs-writing layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
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
;; added to `rs-writing-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rs-writing/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rs-writing/pre-init-PACKAGE' and/or
;;   `rs-writing/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rs-writing-packages
  '(writegood-mode
    markdown-mode
    (org-mode :location built-in))
  "The list of Lisp packages required by the rs-writing layer.

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

(defun rs-writing/post-init-flycheck ()
  (flycheck-define-checker proselint
    "A linter for prose."
    :command ("proselint" source-inplace)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more (not (any " "))))
              (message) line-end))
    :modes (text-mode markdown-mode gfm-mode org-mode))
  (add-to-list 'flycheck-checkers 'proselint)
  (mapc (lambda (mode) (spacemacs/enable-flycheck mode))
        '(text-mode markdown-mode gfm-mode message-mode org-mode))
  )

(defun rs-writing/post-init-markdown-mode ()
  (use-package markdown-mode
    :config
    (progn
      (add-to-list 'gfm-mode-hook 'writegood-mode)
      )
    )
  )

(defun rs-writing/init-writegood-mode ()
  (use-package writegood-mode
    :init
    (progn
      (mapc (lambda (mode-hook) (add-to-list mode-hook 'writegood-mode))
            '(org-mode-hook
              markdown-mode-hook
              text-mode-hook)
            )
      )
    )
  )


(defun rs-writing/init-org-mode ()
  (use-package org
    :config
    (progn
      (add-to-list 'org-mode-hook 'centered-cursor-mode)
      (add-to-list 'org-mode-hook 'variable-pitch-mode)
      )
    )
  (setq
   org-modules '(ol-bbdb
                 ol-bibtex
                 ol-docview
                 ol-eww
                 ol-gnus
                 ol-info
                 ol-irc
                 ol-mhe
                 ol-rmail
                 org-tempo
                 ol-w3m))
  )

;;; packages.el ends here
