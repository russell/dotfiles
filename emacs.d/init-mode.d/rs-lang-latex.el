
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package flymake
  :defer t
  :config
  ;; Flymake latex
  (defun flymake-get-tex-args (file-name)
    (list "pdflatex" (list "-file-line-error"
                           "-draftmode"
                           "-interaction=nonstopmode"
                           file-name))))

(provide 'rs-lang-latex)
;;; rs-lang-latex.el ends here
