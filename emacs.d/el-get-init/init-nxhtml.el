
;; Work Around nxhtml bug.
;; https://gist.github.com/tkf/3951163
(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version 1))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))
