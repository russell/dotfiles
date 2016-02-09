
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package conf-mode
  :defer t
  :config
  (add-hook 'conf-mode-hook 'rs/common-programming-modes))

(provide 'rs-lang-conf)
;;; rs-lang-conf.el ends here
