
(eval-when-compile
  (require 'cl)
  (require 'noflet))

(custom-set-variables
 )

(define-project-type generic-python (generic)
  (look-for "setup.py")
  :irrelevant-files ("^[.]" "^[#]"))

;; Flymake Python
(add-hook 'find-file-hook 'flymake-find-file-hook)

(defun flymake-pycheckers-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-with-folder-structure))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "~/.emacs.d/el-get/flymake-python/pyflymake.py" (list local-file))))

(when (load "flymake" t)
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pycheckers-init)))


;; Smartparens
(add-hook 'python-mode-hook 'smartparens-strict-mode)

(defadvice python-indent-dedent-line-backspace (around python-indent-dedent-line-backspace-around)
  "Replace the backward-delete-char function with the smartparens
one."
  (noflet ((backward-delete-char-untabify (arg &optional killp)
              (sp-backward-delete-char arg)))
    ad-do-it))

(ad-activate 'python-indent-dedent-line-backspace)


;; highlight indentation and symbols
(add-hook 'python-mode-hook 'highlight-indentation-mode)


;;
;; Virtual env
;;

(defun virtualenv-guess-project ()
  "Guess the current project."
  (when (eproject-maybe-turn-on)
    (let* ((dot-venv-file (concat (file-name-as-directory (eproject-root)) ".venv"))
           (venv-name
           (or
            (when (file-exists-p dot-venv-file)
              (with-temp-buffer
                (insert-file-contents dot-venv-file)
                ;; extract virtual env from .venv file
                (if (string-match "[ \t]*$" (buffer-string))
                    (replace-match "" nil nil (buffer-string))
                    (buffer-string))))
            (member* (eproject-name) (virtualenv-workon-complete)
                     :test 'string-equal))))
      (when venv-name
        (virtualenv-workon venv-name)))))


(defun python-custom-path ()
  ;; will be used at work where we have custom paths for some
  ;; projects.
  (cond
   ((and eproject-mode (string-equal (eproject-name) "df"))
    (list
     "--sys-path" (file-truename (eproject-root))
     "--sys-path" (file-truename (concat (eproject-root) "befit"))
     "--sys-path" (file-truename (concat (eproject-root) "dfplugins"))
     "--sys-path" (file-truename (concat (eproject-root) "new_wang/app")))))
  )


;; Disable cedet
;; (remove-hook 'python-mode-hook 'wisent-python-default-setup)


(defun copy-break-point ()
  (interactive)
  (kill-new (concat (buffer-file-name) ":" (number-to-string (line-number-at-pos)))))
