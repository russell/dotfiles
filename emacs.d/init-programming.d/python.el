
(eval-when-compile
  (require 'cl))

(custom-set-variables
 '(py-shell-name "python")
 '(py-split-windows-on-execute-function 'split-window-horizontally)
 '(py-complete-function (quote py-shell-complete))
 '(py-switch-buffers-on-execute-p t)
 '(py-split-windows-on-execute-function (quote split-window-horizontally))
 '(py-split-windows-on-execute-p t)
 '(py-switch-buffers-on-execute-p t)
 '(py-tab-shifts-region-p t)
 '(python-shell-module-completion-string-code "';'.join(__COMPLETER_all_completions('''%s'''))\n"))

;; python-mode keys
(define-key python-mode-map "\C-c\C-c" 'py-execute-def-or-class)
(define-key python-mode-map "\C-c\M-c" 'py-execute-buffer)

(define-project-type python (generic)
  (and (look-for "setup.py")
       (look-for "lib")
       (look-for "bin/activate"))
  :irrelevant-files ("^[.]" "^[#]"))

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

;; Force indentation with spaces.
(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)))

;; highlight indentation and symbols
(add-hook 'python-mode-hook 'highlight-indentation-mode)

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

;; Imenu
(add-hook 'python-mode-hook
  (lambda ()
    (setq imenu-create-index-function 'python-imenu-create-index)))

;;
;; Virtual env
;;

(defun virtualenv-guess-project ()
  "Guess the current project."
  (when (and (eproject-maybe-turn-on)
             (member* (eproject-name) (virtualenv-workon-complete)
                      :test 'string-equal))
    (virtualenv-workon (eproject-name))))


(defun python-custom-path ()
  ;; will be used at work where we have custom paths for some
  ;; projects.
  (cond
   ((string-equal (eproject-name) "df")
    (list
     "--sys-path" (file-truename (eproject-root))
     "--sys-path" (file-truename (concat (eproject-root) "befit"))
     "--sys-path" (file-truename (concat (eproject-root) "dfplugins"))
     "--sys-path" (file-truename (concat (eproject-root) "new_wang/app")))))
  )


;; Disable cedet
(remove-hook 'python-mode-hook 'wisent-python-default-setup)

(defun my-python (&optional argprompt dedicated switch)
  (interactive "P")
  (with-project-root
      (let ((name (let ((spath (split-string default-directory "/")))
                    (if (not (equal (last (car spath)) ""))
                        (last (car spath))
                        (nth (- (length spath) 2) spath)))))
        (py-shell argprompt dedicated "python" switch
                  py-separator-char (format "*Python: %s*" name)))))

;; Use python.el indentation
(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-region-function #'python-indent-region)
             (setq indent-line-function #'python-indent-line-function)))


;; Fix window splitting

(defcustom py-max-split-windows 2
  "When split windows is enabled the maximum windows to allow
  before reusing other windows."
  :type 'number
  :group 'python-mode)

(defun python-convert-path-to-module (path basedir)
  (let ((path (substring (file-name-sans-extension path)
                         (length basedir))))
    (while (string-match "[/]" path)
      (setq path (replace-match "." t t path)))
    path))

(add-hook 'python-mode-hook
          (lambda ()
            (eproject-maybe-turn-on)
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
