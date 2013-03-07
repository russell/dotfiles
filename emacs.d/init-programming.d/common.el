(mapc (lambda (mode)
        ;; diff hl mode
        (add-hook mode 'diff-hl-mode)

        ;; Delete whitespace on save.
        (add-hook mode
                  '(lambda ()
                     (add-hook 'write-contents-functions
                               '(lambda()
                                  (save-excursion
                                    (delete-trailing-whitespace))))))

        ;; flyspell
        (add-hook mode 'flyspell-prog-mode)
        (add-hook mode 'highlight-symbol-mode))

      '(python-mode-hook slime-mode-hook geiser-mode-hook emacs-lisp-mode-hook
                         c-mode-common-hook puppet-mode-hook sh-mode-hook))
