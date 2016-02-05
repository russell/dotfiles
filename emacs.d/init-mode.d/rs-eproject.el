
;;; Code:

(require 'use-package)


(use-package eproject
  :config
  (defun eproject-rgrep ()
    "Search the current project."
    (interactive)
    (let ((default-directory
            (condition-case nil
                (eproject-project-root (eproject-name))
              (error nil))))
      (call-interactively 'rgrep))))

(provide 'rs-eproject)
;;; rs-eproject.el ends here
