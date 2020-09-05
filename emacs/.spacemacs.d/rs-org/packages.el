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

;;; Code:

(defconst rs-org-packages
  '(org-variable-pitch))

(defun rs-org/init-org-variable-pitch()
  (use-package org-variable-pitch
    :config
    (progn
      (add-to-list 'org-mode-hook 'org-variable-pitch-minor-mode)
      (add-to-list 'org-variable-pitch-fixed-faces 'org-link)
      (setq org-variable-pitch-fixed-font "Iosevka Fixed SS11"))
    )
  )

(defun rs-org/post-init-org()
  (setq org-agenda-files '("~/org/"))
  ;; (let ((pitch-fixed-faces '(org-block
  ;;                            org-block-begin-line
  ;;                            org-block-end-line
  ;;                            ;; org-code
  ;;                            ;; org-document-info-keyword
  ;;                            org-done
  ;;                            org-formula
  ;;                            ;; org-meta-line
  ;;                            ;; org-special-keyword
  ;;                            font-lock-comment-face
  ;;                            org-table
  ;;                            org-todo
  ;;                            ;; org-verbatim
  ;;                            shadow
  ;;                            org-date
  ;;                            )))
  ;;   (dolist (face pitch-fixed-faces)
  ;;     (set-face-attribute face nil :inherit 'fixed-pitch)
  ;;   ))

  )

(defun rs-org/post-init-deft()
  (use-package deft
    :defer t
    :init
    (progn
      (setq deft-directory "~/org"
            deft-recursive t
            deft-use-filename-as-title nil
            deft-use-filter-string-for-filename nil)
      )
    )
  )

(defun rs-org/post-init-org-journal()
  (use-package org-journal
    :defer t
    :init
    (progn

      )
    )
  )

;;; packages.el ends here
