
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package conf-mode
  :defer t
  :config
  (rs/add-common-programming-hooks 'conf-mode))

(provide 'rs-lang-conf)
;;; rs-lang-conf.el ends here
