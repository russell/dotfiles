;;; packages.el --- scad layer packages file for Spacemacs.
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

(defconst scad-packages
  '(scad-mode))

(defun scad/init-scad-mode ()
  (use-package scad-mode))

;;; packages.el ends here
