;(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;    (let* ((my-lisp-dir "~/.emacs.d/")
;	   (default-directory my-lisp-dir))
;      (setq load-path (cons my-lisp-dir load-path))
;      (normal-top-level-add-subdirs-to-load-path)))
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/el-get")
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
 '(frame-background-mode (quote dark))
 '(inhibit-startup-screen t)
 '(mac-option-modifier (quote meta)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; color theme config
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (setq color-theme-is-global t)
     (setq color-theme-is-cumulative t)
     (setq color-theme-load-all-themes nil)
     (color-theme-tango)))


(require 'el-get)
(setq el-get-sources
      '(cssh el-get switch-window vkill google-maps nxhtml xcscope yasnippet ipython tidy emacs-goodies-el

        (:name magit
               :after (lambda () (global-set-key (kbd "C-x C-z") 'magit-status)))

        (:name dictionary-el    :type apt-get)
;        (:name emacs-goodies-el :type apt-get)
))

(el-get)




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

;; Autocomplete
(require 'auto-complete)
(global-auto-complete-mode t)
(require 'auto-complete-config)
(ac-config-default)

; Speedbar

; close speedbar when selecting something from it
;(add-hook 'speedbar-visiting-tag-hook '(lambda () (speedbar)))
;(add-hook 'speedbar-visiting-file-hook '(lambda () (speedbar)))

; Python

;; Autofill inside of comments

(defun python-auto-fill-comments-only ()
  (auto-fill-mode 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (not (python-in-literal)))))

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

    ;; Pymacs
    (require 'pymacs)
    (autoload 'pymacs-apply "pymacs")
    (autoload 'pymacs-call "pymacs")
    (autoload 'pymacs-eval "pymacs" nil t)
    (autoload 'pymacs-exec "pymacs" nil t)
    (autoload 'pymacs-load "pymacs" nil t)

    ;; Rope
    (pymacs-load "ropemacs" "rope-")
    (setq ropemacs-enable-autoimport t)
    (ropemacs-mode)

    ;; Autocomplete
    (add-to-list 'ac-omni-completion-sources
		 (cons "\\." '(ac-source-ropemacs)))

    ;; Auto Fill
    ;;(python-auto-fill-comments-only)

    (define-key py-mode-map "\C-m" 'newline-and-indent)
    (define-key py-mode-map [f4] 'speedbar-get-focus)
    ))
(add-hook 'python-mode-hook 'lconfig-python-mode)


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
     (setq po-auto-replace-file-header 'ask)
     (setq po-auto-replace-revision-date 'ask)
     (setq po-default-file-header "")))


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
