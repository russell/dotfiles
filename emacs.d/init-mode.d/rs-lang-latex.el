
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

  (add-hook 'latex-hook 'rs/common-editing-modes)
  (add-hook 'latex-mode-hook 'rs/common-programming-modes))

(provide 'rs-lang-latex)
;;; rs-lang-latex.el ends here
