;;; Code:

(require 'js)
(require 'js2-mode)

(defalias 'js-mode 'js2-mode)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js-indent-level 2)
(setq-default js2-basic-offset 2)
