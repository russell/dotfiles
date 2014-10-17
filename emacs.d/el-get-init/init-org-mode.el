;;; Code:

(defun rs/org-html-mime-code-blocks ()
            (org-mime-change-element-style
             "pre" (format "color: %s; background-color: %s; padding: 0.5em;"
                           "#E6E1DC" "#232323")))

(setq org-export-async-init-file "~/.emacs.d/init-org-export.el")
(add-hook 'org-mime-html-hook 'rs/org-html-mime-code-blocks)
