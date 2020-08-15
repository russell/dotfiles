;;; funcs.el --- arrsim layer functions file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Russell Sim <rusim@RUSIM-M-400X>
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
