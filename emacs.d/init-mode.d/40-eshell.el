;;
;; eshell
;;

(setq eshell-history-size 1000)
(setq eshell-term-name "ansi")
(setq eshell-prompt-function
      (lambda nil
        (concat (abbreviate-file-name (eshell/pwd))
                (if (= (user-uid) 0) " # " " $ "))))
(setq eshell-visual-commands '("vi" "screen" "top" "less" "more" "lynx" "ncftp" "pine" "tin" "trn" "elm" "aptitude"))
(setq eshell-modules-list
      '(eshell-alias eshell-basic eshell-cmpl
                     eshell-dirs eshell-glob eshell-hist
                     eshell-ls eshell-pred eshell-prompt
                     eshell-rebind eshell-script eshell-smart
                     eshell-term eshell-unix eshell-xtra))
(setq eshell-buffer-shorthand t)

(defun my-eshell (&optional buffer)
  (interactive)
  (let* ((tramp-path (when (tramp-tramp-file-p default-directory)
                       (tramp-dissect-file-name default-directory)))
         (host (tramp-file-name-real-host tramp-path))
         (user (if (tramp-file-name-user tramp-path)
                 (format "%s@" (tramp-file-name-user tramp-path)) ""))
         (new-buffer-name (format "*eshell:%s%s*" user host)))

    (if host
        (let ((eshell-buffer-name new-buffer-name))
          (eshell))
      (eshell buffer))))
