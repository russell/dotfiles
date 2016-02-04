
(eval-when-compile
  (require 'use-package))

;;; Code:

(use-package rich-minority
  :config
  (add-to-list 'rm-blacklist " yas")
  (add-to-list 'rm-blacklist " hl-s")
  (add-to-list 'rm-blacklist " ElDoc")
  (add-to-list 'rm-blacklist " Paredit")
  (add-to-list 'rm-blacklist " SliNav")
  (add-to-list 'rm-blacklist " SliExp")
  (add-to-list 'rm-blacklist " SP")
  (add-to-list 'rm-blacklist " ||")
  (add-to-list 'rm-blacklist "/s"))

(provide 'init-rich-minority)
;;; init-rich-minority.el ends here
