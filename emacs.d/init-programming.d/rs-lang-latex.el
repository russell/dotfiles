;; Flymake latex
(defun flymake-get-tex-args (file-name)
    (list "pdflatex" (list "-file-line-error"
			   "-draftmode"
			   "-interaction=nonstopmode"
			   file-name)))
