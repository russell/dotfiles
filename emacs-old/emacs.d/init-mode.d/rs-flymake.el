
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package flymake
  :defer t
  :config
  ;; turn on error logging
  (setq flymake-log-level 0)

  ;; disable gui messages
  (setq flymake-gui-warnings-enabled nil)

  ;; don't start flymake on initial open.
  (setq flymake-start-syntax-check-on-find-file nil))

(provide 'rs-flymake)
;;; rs-flymake.el ends here
