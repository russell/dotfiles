;;; packages.el --- znc layer packages file for Spacemacs.
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

(defconst znc-packages
  '(znc))


(defun znc/init-znc ()
  (use-package znc))

;;; packages.el ends here
