
;;; Code:

(require 'use-package)


(use-package diff
  :config
  (setq diff-switches "-uN")

  ;; enable ansi color for diff output
  (add-hook 'diff-mode-hook
            '(lambda ()
               (require 'ansi-color)
               (ansi-color-apply-on-region (point-min) (point-max)))))

(provide 'rs-diff)
;;; rs-diff.el ends here
