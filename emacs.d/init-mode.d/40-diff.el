;; enable ansi color for diff output
(add-hook 'diff-mode-hook
          '(lambda ()
             (require 'ansi-color)
             (ansi-color-apply-on-region (point-min) (point-max))))
