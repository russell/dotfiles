;;; Code:

(require 'smart-mode-line)

(sml/setup)

(add-to-list 'sml/replacer-regexp-list '("^~/projects/" ":projects:") t)

(sml/apply-theme 'dark)

(provide 'init-smart-mode-line)

;;; init-smart-mode-line.el ends here
