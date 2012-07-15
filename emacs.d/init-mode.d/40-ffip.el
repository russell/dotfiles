(require 'ffip)
(setq ffip-project-root-function 'project-root-current-root)

(defun project-root-current-root ()
  (cdr project-details))

(add-to-list 'ffip-project-file-types
  (list 'python (concat
                 (regexp-opt '(".html" ".htm" ".xhtml"
                               ".css" ".js" ".py" ".png" ".gif"
                               ".rst"))
                 "$")))

(global-set-key (kbd "C-x F") 'ffip-find-file-in-project)
