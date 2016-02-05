
;;; Code:

(require 'use-package)

(use-package vc-git
  :config
  (use-package ansi-color)
  ;; Enable ANSI Color
  (add-hook 'vc-git-log-view-mode-hook
            '(lambda ()
               (require 'ansi-color)
               (let ((buffer-read-only nil))
                 (ansi-color-apply-on-region (point-min) (point-max))))))


(provide 'rs-vc)
;;; rs-vc.el ends here
