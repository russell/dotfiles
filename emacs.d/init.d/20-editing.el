;; follow symlinks to version controlled files
(setq vc-follow-symlinks t)

;;; Set tab width to 4 spaces
(setq default-tab-width 4)

;; Do *not* use tabs for indent
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;; enable override selection
;; (delete-selection-mode t)

;;; auto-insert newline at eof
(setq require-final-newline t)

;; match parenthisis
(show-paren-mode 1)

;; camel case navgation
(global-subword-mode t)

;; electric layout mode
(electric-layout-mode t)

;; show the current column number
(column-number-mode)

;; electric indent mode
;; (electric-indent-mode t)

(require 'epa-file)
(epa-file-enable)


(add-to-list 'safe-local-variable-values '(encoding . utf-8))


;; TODO manually activate subword mode. so that the keys below work.
;; (global-set-key "\M-B" 'backward-word)
;; (global-set-key "\M-F" 'forward-word)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

(setenv "EDITOR" "emacsclient")

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key "\C-co" 'occur)

; Remember position in buffers
(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package

;; Dynamic Abbreviations C-<tab>
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)


; store temporary files in home directory
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp ,user-temporary-file-directory)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))


;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rs/rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))


(defun enable-editing-modes ()
  (interactive)
  (auto-capitalize-mode t)
  (flyspell-mode t))


(defun rs/scratch ()
  (interactive)
  (let ((current-mode major-mode))
    (switch-to-buffer-other-window (get-buffer-create "*scratch*"))
    (goto-char (point-min))
    (when (looking-at ";")
      (forward-line 4)
      (delete-region (point-min) (point)))
    (goto-char (point-max))
    (if (eq current-mode 'emacs-lisp-mode)
        (funcall current-mode))))

;;(global-set-key "\C-h e s" 'scratch)


;; uncamelcase
(defun un-camelcase-string (s &optional sep start)
  "Convert CamelCase string S to lower case with word separator SEP.
    Default for SEP is a hyphen \"-\".

    If third argument START is non-nil, convert words after that
    index in STRING."
  (let ((case-fold-search nil))
    (while (string-match "[A-Z]" s (or start 1))
      (setq s (replace-match (concat (or sep "-")
                                     (downcase (match-string 0 s)))
                             t nil s)))
    (downcase s)))

(defun rs/uncamelcase-word-at-point ()
  (interactive)
  (let* ((case-fold-search nil)
         (start-point (point))
         (beg (and (skip-chars-backward "[:alnum:]:_-") (point)))
         (end (and (skip-chars-forward  "[:alnum:]:_-") (point)))
         (txt (buffer-substring beg end))
         (cml (un-camelcase-string txt "_")) )
    (if cml (progn (delete-region beg end) (insert cml)))
    (goto-char start-point)))

(defun rs/rgrep ()
  "Search the current project."
  (interactive)
  (let ((default-directory
          (if vc-mode
              (vc-call-backend (vc-backend buffer-file-name) 'root default-directory)
            default-directory)))
    (call-interactively 'rgrep)))

(defun rs/pwgen ()
  (interactive)
  (insert
   (with-temp-buffer
     (shell-command "pwgen -c -n -y -B 15 1" t)
     (goto-char (point-min))
     (while (search-forward "\n" nil t)
       (replace-match "" nil t))
     (buffer-substring (point-min) (point-max)))))


(defun rs/copy-file-name ()
  (interactive)
  (kill-new (buffer-file-name)))


(defun rs/timestamp ()
   (interactive)
   (insert (format-time-string "%Y-%m-%dT%H:%M:%S")))
