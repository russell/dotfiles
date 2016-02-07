
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package cc-mode
  :defer t
  :config
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map "\C-z" 'undo)
  (define-key c-mode-base-map [delete] 'c-hungry-delete-forward)
  (define-key c-mode-base-map [backspace] 'c-hungry-delete-backwards)
  (define-key c-mode-base-map [f4] 'speedbar-get-focus)
  (define-key c-mode-base-map [f5] 'next-error)
  (define-key c-mode-base-map [f6] 'run-program)
  (define-key c-mode-base-map [f7] 'compile)
  (define-key c-mode-base-map [f8] 'set-mark-command)
  (define-key c-mode-base-map [f9] 'insert-breakpoint)
  (define-key c-mode-base-map [f10] 'step-over)
  (define-key c-mode-base-map [f11] 'step-into)
  (rs/add-common-programming-hooks 'c-mode-common))

(provide 'rs-lang-c)
;;; rs-lang-c.el ends here
