
;;; Code:

(require 'rs-core)

;; Fix debian sbin paths for some applications.

(when rs/darwin-p
  (setq exec-path
        (cons "/usr/texbin"
              (cons "/usr/local/bin"
                    (cons "/usr/local/sbin" exec-path))))
  (setenv "PATH" (mapconcat 'identity exec-path ":")))

(provide 'rs-darwin)
;;; rs-darwin.el ends here
