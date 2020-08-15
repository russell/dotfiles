
;;; Code:

(eval-when-compile
  (require 'use-package))


(use-package ediff
  :config
  ;; This is what you probably want if you are using a tiling window
  ;; manager under X, such as ratpoison.
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)

  ;; Split the window depending on the current frame size.
  (setq ediff-split-window-function (if (> (frame-width) 150)
                                        'split-window-horizontally
                                      'split-window-vertically)))
(provide 'rs-ediff)
;;; rs-ediff.el ends here
