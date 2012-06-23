;;
;; Lisp
;;


(setq inferior-lisp-program "sbcl --noinform --no-linedit")

(slime-setup '(inferior-slime slime-fancy slime-asdf slime-indentation slime-tramp))
;;                              slime-proxy slime-parenscript))

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
             (paredit-mode)))
(add-hook 'slime-mode-hook
          '(lambda ()
             (flyspell-prog-mode)))
(add-hook 'slime-mode-hook
          '(lambda ()
             (highlight-symbol-mode)))

(setq auto-mode-alist (cons '("\\.paren$" . lisp-mode) auto-mode-alist))

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
             (paredit-mode)))

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (highlight-symbol-mode)))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (elisp-slime-nav-mode t)))

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (define-key emacs-lisp-mode-map "\C-c\C-c" 'eval-defun)))
