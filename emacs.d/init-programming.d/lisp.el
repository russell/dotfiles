;;
;; Lisp
;;
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-mode-hook
          (lambda ()
            (add-hook 'write-contents-functions
                      '(lambda()
                         (save-excursion
                           (delete-trailing-whitespace))))))
(add-hook 'slime-mode-hook
          (lambda ()
            (add-hook 'write-contents-functions
                      'check-parens)))
(add-hook 'slime-mode-hook
          '(lambda ()
             (autopair-mode)))
(add-hook 'slime-mode-hook
          '(lambda ()
             (highlight-symbol-mode)))


(add-hook 'inferior-lisp-mode-hook
          (lambda ()
            (auto-complete-mode 1)))

;;
;; elisp
;;
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (add-hook 'write-contents-functions
                       '(lambda()
                          (save-excursion
                            (delete-trailing-whitespace))))))
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (eldoc-mode)))

;; could be bad, will not let you save at all, until you correct the error
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (add-hook 'write-contents-functions
                      'check-parens)))

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (autopair-mode)))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (highlight-symbol-mode)))
