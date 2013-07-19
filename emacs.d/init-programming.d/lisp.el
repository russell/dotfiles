;;
;; Lisp
;;

;; 'common' lisp mode hooks
(mapc (lambda (mode)
        ;; indent on newline
        (local-set-key (kbd "RET") 'newline-and-indent)

        ;; force balanced parens on save
        (add-hook mode
                  (lambda ()
                    (add-hook 'write-contents-functions
                              'check-parens)))
        ;; paredit mode
        (add-hook mode 'paredit-mode))

      '(lisp-mode
        inferior-emacs-lisp-mode
        lisp-interaction-mode
        common-lisp-mode
        slime-mode-hook
        emacs-lisp-mode-hook
        geiser-mode-hook
        scheme-mode))


(setq inferior-lisp-program "sbcl --noinform --no-linedit")

(slime-setup '(inferior-slime slime-fancy slime-asdf slime-indentation
                              slime-tramp slime-banner slime-compiler-notes-tree))
;; (setq slime-complete-symbol-function 'company-complete)

(defun slime-quickload (system &rest keyword-args)
  "Quickload System."
  (slime-save-some-lisp-buffers)
  (slime-display-output-buffer)
  (message "Performing Quicklisp load of system %S" system)
  (slime-repl-shortcut-eval-async
   `(ql:quickload ,system)
   (slime-asdf-operation-finished-function system)))


(defun slime-find-all-system-names ()
  (flet ((first-char (string &optional (string-start 0))
                     (substring string string-start (1+ string-start))))
      (cl-union
       (mapcar
        (lambda (b)
          (let ((string-start 0)
                (package-name (with-current-buffer b (slime-current-package))))
            (when (equal "#" (first-char package-name string-start))
              (incf string-start))
            (when (equal ":" (first-char package-name string-start))
              (incf string-start))
            (downcase (substring package-name string-start))))
        (cl-remove-if-not
         (lambda (b) (equal (buffer-local-value 'major-mode b)
                            'lisp-mode))
         (buffer-list)))
       (slime-eval '(cl:nunion
                     (swank:list-asdf-systems)
                     (cl:mapcar 'ql-dist:name
                                (ql:system-list))
                     :test 'cl:string=))
       :test 'string-equal)))

;; Quickload a system
(defslime-repl-shortcut slime-repl-quickload
  ("quickload" "+ql" "ql")
  (:handler (lambda ()
              (interactive)
              (let* ((system-names
                      (slime-find-all-system-names))
                     (default-value (slime-find-asd-file
                                     (or default-directory
                                         (buffer-file-name))
                                     system-names))
                     (prompt (concat "System "
                                     (if default-value
                                         (format " (default `%s'): " default-value)
                                       ": ")))
                     (system (completing-read prompt
                                              (slime-bogus-completion-alist system-names)
                                              nil nil nil
                                              'slime-system-history
                                              default-value)))
                (insert "(ql:quickload :" system ")")
                (slime-repl-send-input t))))
  (:one-liner "Quickload a system"))


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

(defslime-repl-shortcut slime-repl-asdf-initialize-source-registry ("asdf-initialize-source-registry")
  (:handler (lambda ()
              (interactive)
              (slime-repl-shortcut-eval-async '(asdf:initialize-source-registry))))
  (:one-liner "Refresh the ASDF source registry."))


;; paren script
(setq auto-mode-alist (cons '("\\.paren$" . lisp-mode) auto-mode-alist))

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

(defun ielm-pop-to-buffer ()
  (interactive)
  (if (get-buffer "*ielm*")
      (pop-to-buffer "*ielm*")
    (progn ;; TODO this needs to use the other one or make a new window
           (ielm))))

(eval-after-load "lisp-mode"
  '(progn
    (define-key emacs-lisp-mode-map "\C-c\C-c" 'eval-defun)
    (define-key emacs-lisp-mode-map "\C-c\C-z" 'ielm-pop-to-buffer)
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
