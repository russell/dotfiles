;;; packages.el --- arrsim layer packages file for Spacemacs.
;;
;; Copyright (c) 2020 Russell Sim
;;
;; Author: Russell Sim <russell.sim@github.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst arrsim-packages
  '(git-auto-commit-mode))


(defun arrsim/init-git-auto-commit-mode ()
  (use-package git-auto-commit-mode
    :config
    (setq gac-automatically-push-p t)))

;;; packages.el ends here
