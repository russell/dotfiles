
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package ruby-mode
  :defer t
  :config
  (add-hook 'ruby-mode-hook 'flycheck-mode-on-safe)
  (rs/add-common-programming-hooks 'ruby-mode))


(provide 'rs-lang-ruby)
;;; rs-lang-ruby.el ends here
