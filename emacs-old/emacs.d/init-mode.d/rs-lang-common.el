
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
        ;; We remove Which Function Mode from the mode line, because
        ;; it's mostly invisible here anyway.
        (assq-delete-all 'which-func-mode mode-line-misc-info))
  (custom-set-variables
   '(which-func-format
     `(:propertize which-func-current face which-func))))


(defun toggle-highlight-symbol ()
  (unless (eq major-mode 'slime-xref-mode)
    (highlight-symbol-mode)))


(defun rs/common-editing-modes ()
  (artbollocks-mode)
  (auto-capitalize-mode)
  (auto-fill-mode)
  (flyspell-mode)
  (turn-on-diff-hl-mode)
  (add-hook 'write-contents-functions
            'delete-trailing-whitespace))


(defun rs/common-programming-modes ()
  (add-to-list 'which-func-modes major-mode)
  (setq fill-column 79)
  (flyspell-prog-mode)
  (smartparens-strict-mode)
  (toggle-highlight-symbol)
  (turn-on-diff-hl-mode)
  (add-hook 'write-contents-functions
            'delete-trailing-whitespace))


(defun rs/common-repl-modes ()
  (toggle-highlight-symbol)
  (smartparens-strict-mode))


(provide 'rs-lang-common)
;;; rs-lang-common.el ends here
