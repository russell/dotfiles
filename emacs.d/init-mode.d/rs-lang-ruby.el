
;;; Code:

(eval-when-compile
  (require 'use-package))


(use-package ruby-mode
  :defer t
  :config
  (add-hook 'ruby-mode-hook 'flycheck-mode-on-safe))


(provide 'rs-lang-ruby)
;;; rs-lang-ruby.el ends here
