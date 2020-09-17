;;; funcs.el --- arrsim layer functions file for Spacemacs.
;;
;; Copyright (c) 2020 Russell Sim
;;
;; Author: Russell Sim <russell.sim@github.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defun arrsim/pwgen (arg)
  (interactive "P")
  (let ((password (with-temp-buffer
                    (shell-command "pwgen -c -n -y -B 15 1" t)
                    (goto-char (point-min))
                    (while (search-forward "\n" nil t)
                      (replace-match "" nil t))
                    (buffer-substring (point-min) (point-max)))))
    (if arg
        password
        (insert password))))
