(require 'smart-mode-line)

(sml/setup)

(add-to-list 'rm-excluded-modes " yas")
(add-to-list 'rm-excluded-modes " hl-s")
(add-to-list 'rm-excluded-modes " ElDoc")
(add-to-list 'rm-excluded-modes " Paredit")
(add-to-list 'rm-excluded-modes " SliNav")
(add-to-list 'rm-excluded-modes " SliExp")
(add-to-list 'rm-excluded-modes " SP")
(add-to-list 'rm-excluded-modes " ||")
(add-to-list 'rm-excluded-modes "/s")

(add-to-list 'sml/replacer-regexp-list '("^~/projects/" ":projects:") t)

(sml/apply-theme 'dark)

(provide 'init-smart-mode-line)

;;; init-smart-mode-line.el ends here
