
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(defalias 'js-mode 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(use-package js2-mode
  :defer t
  :config
  (setq-default js2-basic-offset 2)
  (add-hook 'js2-mode-hook 'rs/common-programming-modes)

  (defun rs/js2-mode-defaults ()
    (js2-imenu-extras-mode +1))
  (add-hook 'js2-mode-hook 'rs/js2-mode-defaults))

(use-package js
  :defer t
  :config
  (setq js-indent-level 2)
  (add-hook 'js-mode-hook 'rs/common-programming-modes))

(provide 'rs-lang-javascript)
;;; rs-lang-javascript.el ends here
