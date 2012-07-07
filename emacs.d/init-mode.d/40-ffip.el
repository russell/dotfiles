(setq ffip-project-root-function 'project-root-current-root)

(defun project-root-current-root ()
  (cdar (project-root-fetch)))

(add-to-list 'ffip-project-file-types
  (list 'python (concat
                 (regexp-opt '(".html" ".htm" ".xhtml"
                               ".css" ".js" ".py" ".png" ".gif"))
                 "$")))

(defun my-ffip-set-current-project ()
  (let (project (project-root-fetch))
    (when project
      (let* ((path (cdar project))
             (type (caar project))
             (name (let ((spath (split-string (cdar project) "/")))
                     (or (last (car spath))
                         (nth (1- (length spath)) spath)))))
        (ffip-set-current-project name path type)))))

(add-hook 'after-change-major-mode-hook 'my-ffip-set-current-project)

(global-set-key (kbd "C-x F") 'ffip-find-file-in-project)
