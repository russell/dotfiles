

;;; Code:

(eval-when-compile
  (require 'use-package))

(defalias 'js-mode 'js2-mode)

(use-package js2-mode
  :config
  (autoload 'js2-mode "js2-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

  (setq-default js2-basic-offset 2)
  (add-hook 'js2-mode-hook 'smartparens-mode))

(use-package js
  :config
  (setq js-indent-level 2))

(provide 'rs-lang-javascript)
;;; rs-lang-javascript.el ends here
