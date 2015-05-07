
;; Fix debian sbin paths for some applications.

(when debian-p
  (let ((exec-path (cons "/usr/sbin" (cons "/sbin" exec-path))))
    (setq ifconfig-program (executable-find "ifconfig"))))

(when darwin-p
  (setq exec-path
        (cons "/usr/texbin"
              (cons "/usr/local/bin"
                    (cons "/usr/local/sbin" exec-path))))
  (setenv "PATH" (mapconcat 'identity exec-path ":")))
