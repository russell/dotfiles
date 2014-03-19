
(eval-when-compile
  (require 'cl)
  (require 'noflet))

(require 'python)

(custom-set-variables
 )

(define-project-type generic-python (generic)
  (look-for "setup.py")
  :irrelevant-files ("^[.]" "^[#]"))

;; Smartparens
(add-hook 'python-mode-hook 'smartparens-strict-mode)

;; Flycheck
(add-hook 'python-mode-hook 'flycheck-mode-on-safe)

(defadvice python-indent-dedent-line-backspace (around python-indent-dedent-line-backspace-around)
  "Replace the backward-delete-char function with the smartparens
one."
  (noflet ((backward-delete-char-untabify (arg &optional killp)
              (sp-backward-delete-char arg)))
    ad-do-it))

(ad-activate 'python-indent-dedent-line-backspace)


;; highlight indentation and symbols
(add-hook 'python-mode-hook 'highlight-indentation-mode)


(defvar python-source-setup-code
  "def source(filename):
    import os
    import subprocess

    command = ['bash', '-c', 'source %s && env' % filename]

    proc = subprocess.Popen(command, stdout = subprocess.PIPE)

    for line in proc.stdout:
        (key, _, value) = line.partition(\"=\")
        os.environ[key] = value[:-1]  # strip newline

    proc.communicate()
")

(add-to-list 'python-shell-setup-codes 'python-source-setup-code)

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
  (kill-new (concat (file-remote-p (buffer-file-name) 'localname)
                    ":"
                    (number-to-string (line-number-at-pos)))))
