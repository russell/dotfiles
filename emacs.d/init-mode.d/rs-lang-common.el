
;;; Code:
(require 'cl-lib)

(require 'which-func)

(setq which-func-modes nil)

(which-function-mode)

(setq-default header-line-format
              '((which-func-mode which-func-format)))

(setq mode-line-misc-info
      ;; We remove Which Function Mode from the mode line, because it's mostly
      ;; invisible here anyway.
      (assq-delete-all 'which-func-mode mode-line-misc-info))

(custom-set-variables
 '(which-func-format
   `(:propertize which-func-current face which-func)))

(defun toggle-highlight-symbol ()
  (unless (eq major-mode 'slime-xref-mode)
    (highlight-symbol-mode)))

(let ((lisp-modes '(slime-mode
                    geiser-mode
                    emacs-lisp-mode))
      (c-like-modes '(python-mode
                      c-mode-common
                      sh-mode
                      conf-mode
                      puppet-mode
                      makefile-mode
                      js2-mode
                      js-mode)))

  (mapc (lambda (mode)
          (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))

            ;; enable which func mode
            (add-to-list 'which-func-modes mode)

            ;; diff hl mode
            (add-hook mode-hook 'diff-hl-mode)

            ;; Delete whitespace on save.
            (add-hook mode-hook
                      '(lambda ()
                         (add-hook 'write-contents-functions
                                   'delete-trailing-whitespace)))
            ;; flyspell
            (add-hook mode-hook 'flyspell-prog-mode)
            ;; highlight symbol
            (add-hook mode-hook 'toggle-highlight-symbol)))

          (cl-concatenate 'list lisp-modes c-like-modes))
  (mapc (lambda (mode)
          (let ((mode-hook (intern (concat (symbol-name 'test-mode) "-hook"))))
            ;; smart parens
            (add-hook mode '(lambda ()
                              (smartparens-mode)
                              (sp-use-paredit-bindings)))))

        (cl-concatenate 'list c-like-modes '(eshell-mode))))
