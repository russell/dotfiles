
;;; Code:

(require 'rs-core)

;; Fix debian sbin paths for some applications.

(use-package net-utils
  :defer t
  :config
  (when rs/debian-p
    (let ((exec-path (cons "/usr/sbin" (cons "/sbin" exec-path))))
      (setq ifconfig-program (executable-find "ifconfig")))))

(when rs/darwin-p
  (setq exec-path
        (cons "/usr/texbin"
              (cons "/usr/local/bin"
                    (cons "/usr/local/sbin" exec-path))))
  (setenv "PATH" (mapconcat 'identity exec-path ":")))

(provide 'rs-debian)
;;; rs-debian.el ends here
