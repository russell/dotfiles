;; -*- Mode: Emacs-Lisp -*-

;(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;    (let* ((my-lisp-dir "~/.emacs.d/")
;	   (default-directory my-lisp-dir))
;      (setq load-path (cons my-lisp-dir load-path))
;      (normal-top-level-add-subdirs-to-load-path)))
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/auto-complete")

;; disable the toolbar
(tool-bar-mode nil)

; set font
(set-default-font "DejaVu Sans Mono:pixelsize=13:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true")
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono:pixelsize=13:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true"))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(el-get-standard-packages (quote ("rainbow-mode" "autopair" "po-mode" "predictive" "highlight-symbol" "highlight-parentheses" "highlight-indentation" "git-emacs" "git-blame" "flymake-point" "flymake-fringe-icons" "folding" "js2-mode" "js-comint" "json" "fic-ext-mode" "eol-conversion" "doxymacs" "dired-plus" "diff-git" "clevercss" "auto-complete-clang" "auctex" "active-menu" "django-mode" "fringe-helper" "csv-mode" "python-mode" "ropemode" "project-root" "color-theme" "apel" "el-get" "cssh" "switch-window" "vkill" "google-maps" "nxhtml" "xcscope" "yasnippet" "tidy" "smex" "rainbow-delimiters" "org-mode" "android-mode" "rst-mode" "magit" "pymacs" "rope" "ropemacs" "ipython" "pylookup" "python-pep8")))
 '(frame-background-mode (quote dark))
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(inhibit-startup-screen t)
 '(mac-option-modifier (quote meta)))
;; color theme config
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (setq color-theme-is-global t)
     (setq color-theme-is-cumulative t)
     (setq color-theme-load-all-themes nil)
     (color-theme-tango)))


(defun add-to-pythonpath (path)
  "Adds a directory to the PYTHONPATH environment
variable. Automatically applies expand-file-name to `path`."
  (setenv "PYTHONPATH"
    (concat (expand-file-name path) ":" (getenv "PYTHONPATH"))))


(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(setq el-get-verbose t)
(setq el-get-sources
      '((:name magit
               :after (lambda () (global-set-key (kbd "C-x C-z") 'magit-status)))

        (:name project-root
	       :type hg
	       :url "http://hg.piranha.org.ua/project-root/"
	       :features project-root)

        (:name pymacs
               :type git
               :url "http://github.com/pinard/Pymacs.git"
               :build ("make")
               :after (lambda ()
                        (add-to-pythonpath (concat el-get-dir "pymacs"))))
        (:name rope
               :type http-tar
               :options ("zxf")
               :url "http://bitbucket.org/agr/rope/get/tip.tar.gz"
               :after (lambda ()
                        (add-to-pythonpath (concat el-get-dir "rope/rope"))))
        (:name ropemode
               :type http-tar
               :options ("zxf")
               :url "http://bitbucket.org/agr/ropemode/get/tip.tar.gz"
               :after (lambda ()
                        (add-to-pythonpath (concat el-get-dir "ropemode/ropemode"))))
        (:name ropemacs
               :type http-tar
               :options ("zxf")
               :url "http://bitbucket.org/agr/ropemacs/get/tip.tar.gz"
	       :depends (pymacs rope ropemode)
               :after (lambda ()
                        (add-to-pythonpath (concat el-get-dir "ropemacs/ropemacs"))
                        (setq ropemacs-local-prefix "C-c C-p")
                        (require 'pymacs)
			(setq pymacs-load-path '( "~/.emacs.d/el-get/rope"
						  "~/.emacs.d/el-get/ropemode"
						  "~/.emacs.d/el-get/ropemacs"
						  "~/.emacs.d/el-get/python-mode"))
                        (pymacs-load "ropemacs" "rope-")))
	(:name python-mode
               :type http-tar
               :options ("zxf")
               :url "http://launchpad.net/python-mode/trunk/5.2.0/+download/python-mode-5.2.0.tgz"
	       :features (python-mode doctest-mode)
	       :depends (pymacs)
	       :post-init (lambda ()
			    (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
			    (add-to-list 'interpreter-mode-alist '("python" . python-mode))
			    (autoload 'python-mode "python-mode" "Python editing mode." t)))
        (:name ipython
	       :depends (python-mode))

))

(el-get 'wait)


; General
(server-start)

(global-set-key (kbd "<f9>") 'recompile)

(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

;; When turning on flyspell-mode, automatically check the entire buffer.
(defadvice flyspell-mode (after advice-flyspell-check-buffer-on-start activate)
  (flyspell-buffer))

;; Dynamic Abbreviations C-<tab>
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

; TRAMP
(setq password-cache-expiry 1000)

;; Autocomplete
(require 'auto-complete)
(global-auto-complete-mode t)
(require 'auto-complete-config)
(ac-config-default)

(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
      (setq value (cons (format "%s%s" prefix element) value))))))

(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")


; Speedbar

; close speedbar when selecting something from it
;(add-hook 'speedbar-visiting-tag-hook '(lambda () (speedbar)))
;(add-hook 'speedbar-visiting-file-hook '(lambda () (speedbar)))

; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

; IDO
(require 'ido)
(ido-mode)

; SMEX
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)

; Flymake
(setq flymake-start-syntax-check-on-find-file nil)

; Project Config
(require 'project-root)
(setq project-roots
      `(("Python project"
         :root-contains-files ("setup.py")
         )))

; Python

;; Autofill inside of comments

(defun python-auto-fill-comments-only ()
  (auto-fill-mode 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (not (python-in-string/comment)))))

(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")



(defun lconfig-python-mode ()
  (progn

    (flyspell-prog-mode)

    ;; Only spaces, no tabs
    (setq indent-tabs-mode nil)

    ;; Always end a file with a newline
    (setq require-final-newline nil)

    ;; Rope
    (ropemacs-mode)

    ;; Autocomplete
    (auto-complete-mode)
    (set (make-local-variable 'ac-sources)
	 (append ac-sources '(ac-source-rope) '(ac-source-yasnippet)))

    (with-project-root (rope-open-project (cdr project-details)))

    ;; Auto Fill
    ;;(python-auto-fill-comments-only)

    (define-key py-mode-map [f4] 'speedbar-get-focus)
    ))
(add-hook 'python-mode-hook 'lconfig-python-mode)
(add-hook 'python-mode-hook '(lambda ()
			       (ropemacs-mode)
			      ))


;; Flymake Python
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "~/bin/pycheckers"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init)))
(load-library "flymake-cursor")
(global-set-key [f10] 'flymake-goto-prev-error)
(global-set-key [f11] 'flymake-goto-next-error)

(add-hook 'before-save-hook 'delete-trailing-whitespace)


; C Mode
(defun lconfig-c-mode ()
  (progn (define-key c-mode-base-map "\C-m" 'newline-and-indent)
         (define-key c-mode-base-map "\C-z" 'undo)
         (define-key c-mode-base-map [delete] 'c-hungry-delete-forward)
         (define-key c-mode-base-map [backspace] 'c-hungry-delete-backwards)
         (define-key c-mode-base-map [f4] 'speedbar-get-focus)
         (define-key c-mode-base-map [f5] 'next-error)
         (define-key c-mode-base-map [f6] 'run-program)
         (define-key c-mode-base-map [f7] 'compile)
         (define-key c-mode-base-map [f8] 'set-mark-command)
         (define-key c-mode-base-map [f9] 'insert-breakpoint)
         (define-key c-mode-base-map [f10] 'step-over)
         (define-key c-mode-base-map [f11] 'step-into)
         (flyspell-prog-mode)
         ))
(add-hook 'c-mode-common-hook 'lconfig-c-mode)

; PO Mode

(setq auto-mode-alist
      (cons '("\\.po\\'\\|\\.po\\." . po-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.po$" . flyspell-mode) auto-mode-alist))
(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)
(add-hook 'po-mode-hook '(lambda () (flyspell-mode)))

(eval-after-load "po-mode"
  '(progn
     (setq po-auto-replace-file-header nil)
     (setq po-auto-replace-revision-date nil)
     (setq po-default-file-header "")))
;(eval-after-load "po-mode"
;  '(load "gb-po-mode"))
; RST Mode

(add-hook 'rst-mode-hook '(lambda () (flyspell-mode)))

; XML Modes

(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

;(setq auto-mode-alist (cons '("\\.html$" . sgml-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.html\.raw$" . sgml-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.dtml$" . sgml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.zpt$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pt$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.zcml$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xhtml$" . nxml-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.rdf$" . nxml-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.php3$" . html-mode) auto-mode-alist))

;; Flymake XML

(when (load "flymake" t)
(defun flymake-xml-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "xmlstarlet" (list "val" "-e" local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.\\(x\\|zc\\)ml\\'" flymake-xml-init))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.\\(ht\\|xht\\)ml\\'" flymake-xml-init))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.[zc]?pt\\'" flymake-xml-init)))
;;;Last minute Flymake customizations
;(add-hook 'xml-mode-hook (lambda () (flymake-mode 1)))
;(add-hook 'html-mode-hook (lambda () (flymake-mode 1)))

; Scrolling

(require 'smooth-scrolling)

;; scroll one line at a time (less "jumpy" than defaults)
;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; match parenthisis
(show-paren-mode 1)


(put 'upcase-region 'disabled nil)

(put 'narrow-to-region 'disabled nil)
