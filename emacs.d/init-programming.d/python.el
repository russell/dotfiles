
(eval-when-compile
  (require 'cl))

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

(defun python-convert-path-to-module (path basedir)
  (let ((path (substring (file-name-sans-extension path)
                         (length basedir))))
    (while (string-match "[/]" path)
      (setq path (replace-match "." t t path)))
    path))

(add-hook 'python-mode-hook
          (lambda ()
            (condition-case e
                (eproject-maybe-turn-on)
              (error (display-warning 'warning
                                      (format "arrsim-python.el: %s" e))))
            (when (ignore-errors (eproject-root))
              (let ((default-directory (eproject-root)))
                (set (make-local-variable 'compilation-directory) (eproject-root))
                (when (and (file-exists-p "./run") (string-equal (eproject-name) "1800respect"))
                  (set (make-local-variable 'compile-command)
                       (concat "./test -- " (python-convert-path-to-module buffer-file-name
                                                                           (concat default-directory "src/")))))
                (when (and (file-exists-p "./bin/dftrial") (string-equal (eproject-name) "df"))
                  (set (make-local-variable 'compile-command)
                       (concat default-directory "bin/dftrial ")))))))


(defun copy-break-point ()
  (interactive)
  (kill-new (concat (buffer-file-name) ":" (number-to-string (line-number-at-pos)))))
