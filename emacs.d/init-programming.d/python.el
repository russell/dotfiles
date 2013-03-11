
;; Ipython dark color theme
;;(setq py-python-command-args '("-i" "--colors=Linux"))
(eval-when-compile
  (require 'cl)
  (require 'auto-complete))

(setq py-shell-name "python")
(setq py-split-windows-on-execute-function 'split-window-horizontally)
(setq py-complete-function (quote py-shell-complete))
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-split-windows-on-execute-function (quote split-window-horizontally))
(setq py-split-windows-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
(setq python-shell-module-completion-string-code "';'.join(__COMPLETER_all_completions('''%s'''))\n")


(define-key python-mode-map "\C-c\C-c" 'py-execute-def-or-class)
(define-key python-mode-map "\C-c\M-c" 'py-execute-buffer)

;; jedi pop mark
(define-key python-mode-map "\M-," 'pop-global-mark)

;; jedi
(setq jedi:setup-keys t)
(setq jedi:key-goto-definition (kbd "M-."))


(define-project-type python (generic)
  (and (look-for "setup.py")
       (look-for "lib")
       (look-for "bin/activate"))
  :irrelevant-files ("^[.]" "^[#]"))

(define-project-type generic-python (generic)
  (look-for "setup.py")
  :irrelevant-files ("^[.]" "^[#]"))

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

(defun ac-python-candidates ()
  (let* (py-split-windows-on-execute-p
         py-switch-buffers-on-execute-p
         (shell (py-choose-shell))
         (proc (or (get-buffer-process shell)
                   (get-buffer-process (py-shell nil nil shell 'noswitch nil)))))
    (if (processp proc)
        (with-syntax-table python-dotty-syntax-table
          (let* ((imports (py-find-imports))
                 (beg (save-excursion (skip-chars-backward "a-zA-Z0-9_.") (point)))
                 (end (point))
                 (word (buffer-substring-no-properties beg end))
                 (code (if imports
                           (concat imports python-shell-module-completion-string-code)
                         python-shell-module-completion-string-code)))
            (python-shell-completion--get-completions word proc code))))))

(ac-define-source python
  '((candidates . ac-python-candidates)
    (symbol . "f")
    (cache)))

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

;; ;; autopair mode
;; (add-hook 'python-mode-hook
;;           '(lambda ()
;;              (autopair-mode)))

;; Auto-Complete
(add-hook 'python-mode-hook
          '(lambda ()
             (setq ac-sources '(ac-source-jedi-direct
                                ac-source-yasnippet))))

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
   ((equal (eproject-name) "df")
    (list
     "--sys-path" (file-truename (concat (eproject-root) "df"))
     "--sys-path" (file-truename (concat (eproject-root) "befit"))
     "--sys-path" (file-truename (concat (eproject-root) "dfplugins"))
     "--sys-path" (file-truename (concat (eproject-root) "new_wang/app")))))
  )

(defun jedi-server-custom-setup ()
  (virtualenv-guess-project)
  (let* (args)
    (when virtualenv-name (setq args (append args `("--virtual-env" ,(file-truename virtualenv-name)))))
    (when (python-custom-path) (setq args (append args (python-custom-path))))
    (when args (set (make-local-variable 'jedi:server-args) args)))
  (jedi:setup))

(add-hook 'python-mode-hook 'jedi-server-custom-setup)


;; XXX doesn't seem to work at the moment,  void variable project-details?
;; FFIP
;; (add-hook 'python-mode-hook
;;   (lambda ()
;;     (unless project-details (project-root-fetch))
;;      (when (project-root-p)
;;          (let* ((default-directory (cdr project-details))
;;                 (name (let ((spath (split-string default-directory "/")))
;;                         (or (last (car spath))
;;                             (nth (1- (length spath)) spath)))))
;;            (ffip-set-current-project name default-directory 'python)))))

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

;; (defun py-choose-shell (&optional arg pyshell dedicated)
;;   (with-project-root
;;       (car (loop for buffer in (buffer-list)
;;                  when (and
;;                        (string-match "^\*Python: .*\*$" (buffer-name buffer))
;;                        (equal (buffer-local-value 'default-directory buffer)
;;                               default-directory))
;;                  collect (buffer-name buffer)))))

;; (defun py-buffer-name-prepare (name &optional sepchar dedicated)
;;   (let ((py-file-buffer default-directory)
;;         (py-name (cond ((string= "ipython" name)
;;                         (replace-regexp-in-string "ipython" "IPython" name))
;;                        ((string= "jython" name)
;;                         (replace-regexp-in-string "jython" "Jython" name))
;;                        ((string= "python" name)
;;                         (replace-regexp-in-string "python" "Python" name))
;;                        ((string-match "python2" name)
;;                         (replace-regexp-in-string "python2" "Python2" name))
;;                        ((string-match "python3" name)
;;                         (replace-regexp-in-string "python3" "Python3" name))
;;                        (t name))))
;;     (with-project-root
;;         (let ((project-name (let ((spath (split-string default-directory "/")))
;;                               (if (not (equal (last (car spath)) ""))
;;                                   (last (car spath))
;;                                 (nth (- (length spath) 2) spath)))))
;;           (format "*%s: %s*" py-name project-name)))))

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
            (when (ignore-errors (eproject-root))
              (let ((default-directory (eproject-root)))
                (when (and (file-exists-p "./run") (string-equal (eproject-name) "1800respect"))
                  (set (make-local-variable 'compile-command)
                       (concat "./test -- " (python-convert-path-to-module buffer-file-name
                                                                           (concat default-directory "src/")))))
                (when (and (file-exists-p "./bin/dftrial") (string-equal (eproject-name) "df"))
                  (set (make-local-variable 'compile-command)
                       (concat default-directory "bin/dftrial " buffer-file-name)))))))

(defun py-shell-manage-windows (switch py-split-windows-on-execute-p py-switch-buffers-on-execute-p oldbuf py-buffer-name)
  (cond (;; split and switch
         (unless (eq switch 'noswitch)
           (and py-split-windows-on-execute-p
                (or (eq switch 'switch)
                    py-switch-buffers-on-execute-p)))
         (if (< (count-windows) py-max-split-windows)
           (funcall py-split-windows-on-execute-function)
           (switch-to-buffer-other-window py-buffer-name)))
        ;; split, not switch
        ((and py-split-windows-on-execute-p
              (or (eq switch 'noswitch)
                  (not (eq switch 'switch))))
         (if (< (count-windows) py-max-split-windows)
             (progn
               (funcall py-split-windows-on-execute-function)
               (display-buffer py-buffer-name))
           (display-buffer py-buffer-name 'display-buffer-reuse-window)))
        ;; no split, switch
        ((or (eq switch 'switch)
             (and (not (eq switch 'noswitch))
                  py-switch-buffers-on-execute-p))
         (pop-to-buffer py-buffer-name)
         (goto-char (point-max)))
        ;; no split, no switch
        ((or (eq switch 'noswitch)
             (not py-switch-buffers-on-execute-p))
         (set-buffer oldbuf)
         (switch-to-buffer (current-buffer)))))

(defun copy-break-point ()
  (interactive)
  (kill-new (concat (buffer-file-name) ":" (number-to-string (line-number-at-pos)))))
