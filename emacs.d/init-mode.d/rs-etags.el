
;;; Code:

(require 'use-package)

;;
;; etags
;;
(defvar rs/path-to-ctags "ctags")

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" rs/path-to-ctags dir-name (directory-file-name dir-name))))

(defun project-root-create-tags ()
  "Create tags file using the curret project root."
  (interactive)
  (with-project-root
      (shell-command
       (format "%s -eR --extra=+q" rs/path-to-ctags))))

(provide 'rs-etags)
;;; rs-etags.el ends here
