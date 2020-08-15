
;;; Code:

(eval-when-compile
  (require 'use-package))


(use-package dired-x)

(use-package dired
  :config
  (setq-default dired-omit-files-p t) ; this is buffer-local variable
  (setq-default dired-hide-details-hide-information-lines nil)

  (setq dired-omit-files
        (concat dired-omit-files "\\|^\\..+$"))

  ;; unbind the help key
  (define-key dired-mode-map [f1] nil))

(provide 'rs-dired)
;;; rs-dired.el ends here
