
;; Fix debian sbin paths for some applications.

(when debian-p
  (let ((exec-path (cons "/usr/sbin" (cons "/sbin" exec-path))))
    (setq ifconfig-program (executable-find "ifconfig"))))
