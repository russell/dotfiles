
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'cl-lib)

(use-package which-func
  :init
  (which-function-mode)
  :config
  (setq which-func-modes nil)
  (setq-default header-line-format
                '((which-func-mode which-func-format)))
  (setq mode-line-misc-info
        ;; We remove Which Function Mode from the mode line, because it's mostly
        ;; invisible here anyway.
        (assq-delete-all 'which-func-mode mode-line-misc-info))
  (custom-set-variables
   '(which-func-format
     `(:propertize which-func-current face which-func))))


(defun toggle-highlight-symbol ()
  (unless (eq major-mode 'slime-xref-mode)
    (highlight-symbol-mode)))


(defun rs/add-common-editing-hooks (mode)
  (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))
    (add-hook mode-hook 'artbollocks-mode)
    (add-hook mode-hook 'auto-capitalize-mode)
    (add-hook mode-hook 'auto-fill-mode)
    (add-hook mode-hook 'flyspell-mode)
    (add-hook mode-hook 'turn-on-diff-hl-mode)
    (add-hook mode-hook
              '(lambda ()
                 (add-hook 'write-contents-functions
                           'delete-trailing-whitespace)))))


(defun rs/add-common-programming-hooks (mode)
  (add-to-list 'which-func-modes mode)
  (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))
    (add-hook mode-hook 'fci-mode)
    (add-hook mode-hook 'flyspell-prog-mode)
    (add-hook mode-hook 'smartparens-strict-mode)
    (add-hook mode-hook 'toggle-highlight-symbol)
    (add-hook mode-hook 'turn-on-diff-hl-mode)
    (add-hook mode-hook
              '(lambda ()
                 (add-hook 'write-contents-functions
                           'delete-trailing-whitespace)))))

(defun rs/add-common-repl-hooks (mode)
  (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))
   (add-hook mode-hook 'toggle-highlight-symbol)
   (add-hook mode-hook 'smartparens-strict-mode)))


(provide 'rs-lang-common)
;;; rs-lang-common.el ends here
