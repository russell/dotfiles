
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package tex-mode
  :defer t
  :config
  ;; Flymake latex
  (defun flymake-get-tex-args (file-name)
    (list "pdflatex" (list "-file-line-error"
                           "-draftmode"
                           "-interaction=nonstopmode"
                           file-name)))
  (rs/add-common-editing-hooks 'latex-mode)
  (rs/add-common-programming-hooks 'latex-mode))

(provide 'rs-lang-latex)
;;; rs-lang-latex.el ends here
