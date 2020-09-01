;;; packages.el --- rs-writing layer packages file for Spacemacs.
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

(defconst rs-writing-packages
  '(writegood-mode
    markdown-mode
    (org-mode :location built-in)))

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
      (add-to-list 'gfm-mode-hook 'variable-pitch-mode)
      (add-to-list 'markdown-mode-hook 'variable-pitch-mode)
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
      (add-to-list 'org-mode-hook 'auto-fill-mode)
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
