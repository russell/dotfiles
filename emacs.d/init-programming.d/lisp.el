;;
;; Lisp
;;

;; common lisp mode hooks
(mapc (lambda (mode)
        ;; force balanced parens on save
        (add-hook mode
                  (lambda ()
                    (add-hook 'write-contents-functions
                              'check-parens)))

        ;; paredit mode
        (add-hook mode 'paredit-mode))

      '(slime-mode-hook emacs-lisp-mode-hook geiser-mode-hook))


(setq inferior-lisp-program "sbcl --noinform --no-linedit")

(slime-setup '(inferior-slime slime-fancy slime-asdf slime-indentation
                              slime-tramp slime-banner slime-compiler-notes-tree))

;;                              slime-proxy slime-parenscript))

(setq slime-complete-symbol*-fancy t)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)

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

(defslime-repl-shortcut slime-max-debug ("max-debug")
  (:handler
   (lambda ()
     (interactive)
     (insert "(declaim (optimize (debug 3) (speed 0) (safety 3) (compilation-speed 0)))")
     (slime-repl-send-input)))
  (:one-liner "Declaim max debug properties"))

(defslime-repl-shortcut slime-max-speed ("max-speed")
  (:handler (lambda ()
              (interactive)
              (insert "(declaim (optimize (debug 0) (speed 3) (safety 0) (compilation-speed 0)))")
              (slime-repl-send-input)))
  (:one-liner "Declaim max speed optimisation properties"))

(defslime-repl-shortcut slime-max-sanity ("max-sanity")
  (:handler (lambda ()
              (interactive)
              (insert "(declaim (optimize (debug 2) (speed 2) (safety 2) (compilation-speed 2)))")
              (slime-repl-send-input)))
  (:one-liner "Declaim sane optimisation properties"))

;; paren script
(setq auto-mode-alist (cons '("\\.paren$" . lisp-mode) auto-mode-alist))

;; (add-hook 'inferior-lisp-mode-hook
;;           (lambda ()
;;             (auto-complete-mode 1)))
(add-hook 'slime-repl-mode 'paredit-mode)


(defun slime-eval-last-expression-in-repl1 (prefix)
  (interactive "P")
  (let ((origional-buffer (current-buffer)))
    (slime-eval-last-expression-in-repl prefix)
    (pop-to-buffer origional-buffer)))

;;
;; elisp
;;
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)

(eval-after-load "lisp-mode"
  '(progn
    (define-key emacs-lisp-mode-map "\C-c\C-c" 'eval-defun)
    (define-key emacs-lisp-mode-map "\C-c\M-c" 'eval-buffer)))

(add-hook 'emacs-lisp-mode-hook 'elisp-slime-expand-mode)

;;
;; ielm mode
;;
(add-hook 'ielm-mode-hook 'eldoc-mode)
(add-hook 'ielm-mode-hook 'paredit-mode)

;;
;; scheme
;;
(eval-after-load "geiser-mode"
  '(progn
    (define-key geiser-mode-map "\C-c\C-c" 'geiser-eval-definition)))

(add-hook 'geiser-mode-hook 'paredit-mode)
