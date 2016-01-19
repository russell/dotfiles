
;;; Code:

(require 'multiple-cursors-core)

(add-to-list 'mc--default-cmds-to-run-for-all
             'hungry-delete-backward)

(add-to-list 'mc--default-cmds-to-run-for-all
             'python-indent-dedent-line-backspace)

(provide 'init-multiple-cursors)
;;; init-multiple-cursors.el ends here
