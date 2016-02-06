

;;; Code:

(eval-when-compile
  (require 'use-package))

(defalias 'js-mode 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(use-package js2-mode
  :config
  (setq-default js2-basic-offset 2)
  (add-hook 'js2-mode-hook 'smartparens-mode)

  (defun rs/js2-mode-defaults ()
    (js2-imenu-extras-mode +1))
  (add-hook 'js2-mode-hook 'rs/js2-mode-defaults))

(use-package js
  :config
  (setq js-indent-level 2))

(provide 'rs-lang-javascript)
;;; rs-lang-javascript.el ends here
