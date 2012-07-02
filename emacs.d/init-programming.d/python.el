; Python


(setq py-python-command-args '("-i" "--colors=Linux"))
(setq py-shell-name "ipython")
(setq py-split-windows-on-execute-function 'split-window-horizontally)

(define-key python-mode-map "\C-c\C-c" 'py-execute-def-or-class)
(define-key python-mode-map "\C-c\M-c" 'py-execute-buffer)


;; Autofill inside of comments
(defun python-auto-fill-comments-only ()
  (auto-fill-mode 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (not (python-in-string/comment)))))

(defun lconfig-python-mode ()
  (progn
    ;; (define-key python-mode-map [(meta q)] 'py-fill-paragraph)

    (defun ac-python-find ()
      "Python `ac-find-function'."
      (require 'thingatpt)
      (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
        (if (null symbol)
            (if (string= "." (buffer-substring (- (point) 1) (point)))
                (point)
              nil)
          symbol)))

    (defun ac-python-candidate ()
      "Python `ac-candidates-function'"
      (let (candidates)
        (dolist (source ac-sources)
          (if (symbolp source)
              (setq source (symbol-value source)))
          (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
                 (requires (cdr-safe (assq 'requires source)))
                 cand)
            (if (or (null requires)
                    (>= (length ac-target) requires))
                (setq cand
                      (delq nil
                            (mapcar (lambda (candidate)
                                      (propertize candidate 'source source))
                                    (funcall (cdr (assq 'candidates source)))))))
            (if (and (> ac-limit 1)
                     (> (length cand) ac-limit))
                (setcdr (nthcdr (1- ac-limit) cand) nil))
            (setq candidates (append candidates cand))))
        (delete-dups candidates)))

    ;;(ac-set-trigger-key "TAB")
    ;;(setq ac-sources '(ac-source-rope ac-source-yasnippet))
    (set (make-local-variable 'ac-find-function) 'ac-python-find)
    (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
    ))
;;(add-hook 'python-mode-hook 'lconfig-python-mode)


;; Flymake Python
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; (when (load "flymake" t)
;;   (defun flymake-pycheckers-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-with-folder-structure))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "~/.emacs.d/el-get/flymake-python/pyflymake.py" (list local-file))))

;;    (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.py\\'" flymake-pycheckers-init)))

;; force indentation with spaces
(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)))

;; flyspell mode
(add-hook 'python-mode-hook
          '(lambda ()
             (flyspell-prog-mode)))

;; highlight indentation and symbols
(add-hook 'python-mode-hook
          '(lambda ()
             (highlight-indentation-on)
             (highlight-symbol-mode 1)))

;; ;; autopair mode
;; (add-hook 'python-mode-hook
;;           '(lambda ()
;;              (autopair-mode)))

;; delete whitespace on save
(add-hook 'python-mode-hook
          '(lambda ()
             (add-hook 'write-contents-functions
                       '(lambda()
                          (save-excursion
                            (delete-trailing-whitespace))))))


;; (add-hook 'python-mode-hook
;;           #'(lambda ()
;;               (push '(?' . ?')
;;                     (getf autopair-extra-pairs :code))
;;               (setq autopair-handle-action-fns
;;                     (list #'autopair-default-handle-action
;;                           #'autopair-python-triple-quote-action))))

(add-hook 'python-mode-hook
          (lambda ()
            (defvar py-mode-map python-mode-map)
            (defvar py-shell-map python-shell-map)))

;; disable cedet
(remove-hook 'python-mode-hook 'wisent-python-default-setup)
