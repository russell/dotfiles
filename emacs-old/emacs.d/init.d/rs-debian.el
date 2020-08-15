
;;; Code:

(require 'rs-core)

;; Fix debian sbin paths for some applications.

(use-package net-utils
  :defer t
  :config
  (when rs/debian-p
    (let ((exec-path (cons "/usr/sbin" (cons "/sbin" exec-path))))
      (setq ifconfig-program (executable-find "ifconfig")))))

(provide 'rs-debian)
;;; rs-debian.el ends here
