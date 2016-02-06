
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package eproject
  :defer t
  :config
  (defun eproject-rgrep ()
    "Search the current project."
    (interactive)
    (let ((default-directory
            (condition-case nil
                (eproject-project-root (eproject-name))
              (error nil))))
      (call-interactively 'rgrep))))

(provide 'init-eproject)
;;; init-eproject.el ends here
