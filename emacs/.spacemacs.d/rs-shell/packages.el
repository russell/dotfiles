;;; packages.el --- rs-shell layer packages file for Spacemacs.
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
;; added to `rs-shell-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rs-shell/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rs-shell/pre-init-PACKAGE' and/or
;;   `rs-shell/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rs-shell-packages
  '(bash-completion
    fish-completion
    (eshell :location built-in)
    )
  "The list of Lisp packages required by the rs-shell layer.

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
              eshell-rebind
              eshell-script
              eshell-smart
              eshell-term
              eshell-tramp
              eshell-unix
              eshell-xtra))
      )
;;; packages.el ends here
