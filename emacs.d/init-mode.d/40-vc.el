;; enable ansi color
(add-hook 'vc-git-log-view-mode
          '(lambda ()
             (require 'ansi-color)
             (let ((buffer-read-only nil))
               (ansi-color-apply-on-region (point-min) (point-max)))))
