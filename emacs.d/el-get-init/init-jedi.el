(custom-set-variables
 '(jedi:goto-follow t)
 '(jedi:key-complete (kbd ""))
 '(jedi:key-goto-definition (kbd "M-."))
 '(jedi:setup-keys t))

;; jedi pop mark
(eval-after-load 'python-mode
  '(define-key python-mode-map "\M-," 'pop-global-mark))

(eval-after-load 'company
  '(progn
     (defun jedi:company-backend (command &optional arg &rest ignored)
       (case command
         (prefix (and (derived-mode-p 'python-mode)
                      buffer-file-name
                      (not (company-in-string-or-comment))
                      (jedi:complete-request)
                      (company-grab-symbol)))
         (candidates
          (mapcar (lambda (e) (plist-get e :word))  jedi:complete-reply))
         (meta
          (let ((doc-string
                 (plist-get (car (remove-if-not
                                  (lambda (e) (string-equal (plist-get e :word) arg))
                                  jedi:complete-reply))
                            :doc)))
            (when doc-string
              (substring doc-string 0 (string-match "\n" doc-string)))))
         (no-cache t)
         (sorted nil)))
     (add-to-list 'company-backends 'jedi:company-backend)))

(defun jedi:ac-direct-matches ()
    (mapcar
     (lambda (x)
       (destructuring-bind (&key word doc description symbol)
           x
         (popup-make-item word
                          :symbol symbol
                          :document (unless (equal doc "") doc))))
     jedi:complete-reply))


(eval-after-load 'jedi
  '(progn
    (custom-set-faces
     '(jedi:highlight-function-argument ((t (:inherit eldoc-highlight-function-argument)))))

    (setq jedi:tooltip-method nil)
    (defun jedi-eldoc-documentation-function ()
      (deferred:nextc
        (jedi:call-deferred 'get_in_function_call)
        #'jedi-eldoc-show)
      nil)

    (defun jedi-eldoc-show (args)
      (when args
        (let ((eldoc-documentation-function
               (lambda ()
                 (apply #'jedi:get-in-function-call--construct-call-signature args))))
          (eldoc-print-current-symbol-info))))))

(defun jedi-server-custom-setup ()
  (ignore-errors (virtualenv-guess-project))
  (let* (args)
    (when virtualenv-name (setq args (append args `("--virtual-env" ,(file-truename virtualenv-name)))))
    (when (python-custom-path) (setq args (append args (python-custom-path))))
    (when args (set (make-local-variable 'jedi:server-args) args)))
  (jedi:setup)
  (remove-hook 'post-command-hook 'jedi:handle-post-command t)
  (eldoc-mode)
  (set (make-local-variable 'eldoc-documentation-function) #'jedi-eldoc-documentation-function))

;; (add-hook 'python-mode-hook 'jedi-server-custom-setup)
