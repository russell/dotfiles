;;
;; Lisp
;;


(setq inferior-lisp-program "sbcl --noinform --no-linedit")

(slime-setup '(inferior-slime slime-fancy slime-asdf slime-indentation slime-tramp slime-banner slime-compiler-notes-tree))
;;                              slime-proxy slime-parenscript))
(setq slime-complete-symbol*-fancy t)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)

;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
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
;; Auto-Complete
(add-hook 'slime-mode-hook
          '(lambda ()
             (require 'ac-slime)
             (setq ac-sources '(ac-source-abbrev ac-source-words-in-same-mode-buffers ac-source-slime-fuzzy))))


(defun slime-quickload (system &rest keyword-args)
  "Quickload System."
  (slime-save-some-lisp-buffers)
  (slime-display-output-buffer)
  (message "Performing Quicklisp load of system %S" system)
  (slime-repl-shortcut-eval-async
   `(ql:quickload ,system)
   (slime-asdf-operation-finished-function system)))

(defslime-repl-shortcut slime-repl-load-system ("quickload")
  (:handler (lambda ()
              (interactive)
              (slime-quickload (slime-read-system-name))))
  (:one-liner "Compile (as needed) and load an ASDF system."))


(setq auto-mode-alist (cons '("\\.paren$" . lisp-mode) auto-mode-alist))

;; (add-hook 'inferior-lisp-mode-hook
;;           (lambda ()
;;             (auto-complete-mode 1)))

(defun slime-eval-last-expression-in-repl1 (prefix)
  (interactive "P")
  (let ((origional-buffer (current-buffer)))
    (slime-eval-last-expression-in-repl prefix)
    (pop-to-buffer origional-buffer)))
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
          (lambda ()
            (flyspell-prog-mode)))

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (define-key emacs-lisp-mode-map "\C-c\C-c" 'eval-defun)
             (define-key emacs-lisp-mode-map "\C-c\M-c" 'eval-buffer)))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (elisp-slime-expand-mode t)))

;;
;; ielm mode
;;
(add-hook 'ielm-mode-hook
          (lambda ()
            (eldoc-mode)))


;;
;; scheme
;;

(add-hook 'geiser-mode-hook
          '(lambda ()
             (paredit-mode)))

(add-hook 'geiser-mode-hook
          '(lambda ()
             (highlight-symbol-mode)))

(add-hook 'geiser-mode-hook
          (lambda ()
            (flyspell-prog-mode)))
