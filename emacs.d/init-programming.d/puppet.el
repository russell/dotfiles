
(defun puppet-block-align ()
  "align the => characters for a block"
  (interactive)
  (save-excursion
    (let ((apoint (search-backward "{" nil t))
	  (epoint (search-forward "}" nil t)))
      (when apoint
        (align-regexp apoint epoint "\\(\\s-*\\)=>" 1 1)))))
