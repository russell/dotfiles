;; -*- Mode: Emacs-Lisp -*-

;(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;    (let* ((my-lisp-dir "~/.emacs.d/")
;	   (default-directory my-lisp-dir))
;      (setq load-path (cons my-lisp-dir load-path))
;      (normal-top-level-add-subdirs-to-load-path)))
(add-to-list 'load-path "~/.emacs.d/")

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
 '(el-get-standard-packages (quote ("markdown-mode" "po-mode+" "auto-complete" "popup-kill-ring" "color-theme-tangotango" "rainbow-mode" "autopair" "po-mode" "predictive" "highlight-symbol" "highlight-parentheses" "highlight-indentation" "git-emacs" "git-blame" "flymake-point" "flymake-fringe-icons" "folding" "js2-mode" "js-comint" "json" "fic-ext-mode" "eol-conversion" "doxymacs" "dired-plus" "diff-git" "clevercss" "auto-complete-clang" "auctex" "active-menu" "django-mode" "fringe-helper" "csv-mode" "python-mode" "ropemode" "project-root" "color-theme" "apel" "el-get" "cssh" "switch-window" "vkill" "google-maps" "nxhtml" "xcscope" "yasnippet" "tidy" "smex" "rainbow-delimiters" "org-mode" "android-mode" "rst-mode" "magit" "pymacs" "rope" "ropemacs" "ipython" "pylookup" "python-pep8")))
 '(frame-background-mode (quote dark))
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(inhibit-startup-screen t)
 '(mac-option-modifier (quote meta)))


(defun add-to-pythonpath (path)
  "Adds a directory to the PYTHONPATH environment
variable. Automatically applies expand-file-name to `path`."
  (setenv "PYTHONPATH"
    (concat (expand-file-name path) ":" (getenv "PYTHONPATH"))))

;; '(el-get-standard-packages (quote ("theme-roller" "color-theme" "apel" "el-get" "cssh" "switch-window" "vkill" "google-maps" "nxhtml" "xcscope" "yasnippet" "tidy" "smex" "rainbow-delimiters" "org-mode" "android-mode" "rst-mode" "magit" "project-root"
;;"ac-dabbrev" "ack" "active-menu" "ahg" "ant" "asciidoc" "auctex" "auto-complete-clang" "babel" "bbcode-mode" "circe" "clevercss" "color-theme-tango-2" "csv-mode" "darcsum" "diff-git" "dig" "dired-plus" "dired-sync" "django-mode" "doxymacs" "dtrt-indent" "durendal" "dvc" "elein" "elunit" "eol-conversion" "erc-track-score" "ergoemacs-keybindings" "erlware-mode" "escreen" "ess"

;;"ethan-wspace"

;;"fic-ext-mode" "filladapt" "fit-frame" "flex-mode" "flim" "flyguess" "flymake-fringe-icons" "flymake-point" "folding" "frame-fns" "frame-cmds" "fringe-helper" "fsharp-mode" "full-ack" "fuzzy-format" "g-client" "geiser" "git-blame" "git-emacs" "gnuplot-mode" "gnus-identities" "go-mode" "google-weather" "goto-last-change" "gravatar" "grep+" "haml-mode" "highlight-indentation" "highlight-parentheses" "highlight-symbol" "hl-sexp" "hs-lint" "html-script-src" "icomplete+" "ido-hacks" "iedit" "imaxima" "initsplit" "io-mode" "ioccur" "java-mode-indent-annotations" "keats" "keywiz" "kpm-list" "levenshtein" "list-processes+" "lively" "loc-changes" "magithub" "mailcrypt" "mailq" "markdown-mode" "matlab-mode" "maxframe" "mediawiki" "mingus" "minimap" "mmm-mode" "mo-git-blame" "mode-compile" "moz-repl" "multi-term" "mwe-log-commands" "n3-mode" "nagios-mode" "naquadah-theme" "nav" "notify" "nsis-mode" "nterm" "oauth" "offlineimap" "openwith" "org-buffers" "org-fstree" "org-website" "osc" "package" "package24" "paredit" "pastebin" "pg" "pgsql-linum-format" "php-mode-improved" "php-mode" "pkgbuild-mode" "planner" "po-mode" "point-stack" "pointback" "popup-kill-ring" "pos-tip" "pov-mode" "predictive" "processing-mode" "project-local-variables" "prolog-el" "psvn" "puppet-mode" "quack" "rainbow-mode" "rcirc-groups" "rdebug" "rect-mark" "reftex" "regex-tool" "remember" "revive" "rhtml-mode" "ri-emacs" "rinari" "rspec-mode" "rt-liberation" "rudel" "sass-mode" "scratch" "scss-mode" "semi" "session" "shell-current-directory" "sicp" "smart-tab" "smartchr" "smarttabs" "smarty-mode" "sml-mode" "sml-modeline" "smooth-scroll" "smooth-scrolling" "ssh-config" "string-template" "sudo-save" "swank-clojure" "tablature-mode" "tail" "textile-mode" "tuareg-mode" "txt2tags-mode" "undo-tree" "vc-darcs" "verbiste" "virtualenv" "weblogger-el" "whole-line-or-region" "wikipedia-mode" "workgroups" "wrap-region" "wwtime" "xclip" "xcscope+" "xml-parse" "xml-rpc-el" "yaml-mode")))


(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(setq el-get-verbose t)
(setq el-get-sources

      '(rainbow-mode autopair predictive highlight-symbol highlight-parentheses git-emacs git-blame mo-git-blame virtualenv flymake-point flymake-fringe-icons folding js2-mode js-comint json fic-ext-mode eol-conversion doxymacs dired-plus diff-git clevercss auto-complete auto-complete-clang auctex active-menu django-mode fringe-helper csv-mode color-theme apel el-get cssh switch-window vkill google-maps nxhtml xcscope yasnippet tidy smex rainbow-delimiters org-mode android-mode rst-mode pylookup python-pep8
	(:name magit
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

	(:name color-theme-tangotango
	       :type git
	       :features color-theme-tangotango
	       :url "git@github.com:russell/color-theme-tangotango.git")

	(:name highlight-indentation
	       :features highlight-indentation
	       :type git
	       :url "https://github.com/antonj/Highlight-Indentation-for-Emacs")

	(:name pycheckers
	       :type hg
	       :url "https://bitbucket.org/jek/sandbox")

	(:name po-mode
	       :type http
	       :url "http://cvs.savannah.gnu.org/viewvc/*checkout*/gettext/gettext/gettext-tools/misc/po-mode.el"
	       :features po-mode)

	(:name po-mode+
	       :type emacswiki
	       :features po-mode+
	       :depends po-mode
	       :post-init (lambda ()
			    (add-to-list 'auto-mode-alist '("\\.po$" . po-mode+))
			    (add-to-list 'auto-mode-alist '("\\.pot$" . po-mode+))))

))

(el-get 'wait)


; General
(server-start)


;; color theme config
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (setq color-theme-is-global t)
     (setq color-theme-is-cumulative t)
     (setq color-theme-load-all-themes nil)
     (color-theme-tangotango)))


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


;; follow symlinks to version controlled files
(setq vc-follow-symlinks t)

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
(eval-after-load "smex"
  '(progn
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'smex-major-mode-commands)
    (global-set-key (kbd "C-c M-x") 'smex-update-and-run)))

; Flymake
(setq flymake-start-syntax-check-on-find-file nil)

; Project Config
(setq project-roots
      `(("Python rope project"
	 :root-contains-files (".ropeproject")
         )
	("Python project"
         :root-contains-files ("setup.py")
         )))

; Python

;; Autofill inside of comments

(defun python-auto-fill-comments-only ()
  (auto-fill-mode 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (not (python-in-string/comment)))))


(defun lconfig-python-mode ()
  (progn

    (flyspell-prog-mode)

    ;; Only spaces, no tabs
    (setq indent-tabs-mode nil)

    ;; Always end a file with a newline
    (setq require-final-newline nil)

    (eval-after-load 'python
      '(progn
	 ;; Rope
	 (ropemacs-mode)
	 (setq ropemacs-enable-autoimport t)
	 ))

    (with-project-root (rope-open-project (cdr project-details)))

    ;; Autocomplete
    (auto-complete-mode)

    ;; Auto Fill
    ;;(python-auto-fill-comments-only)

    (define-key py-mode-map [f4] 'speedbar-get-focus)

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

    (ac-set-trigger-key "TAB")
    (setq ac-sources '(ac-source-rope ac-source-yasnippet))
    (set (make-local-variable 'ac-find-function) 'ac-python-find)
    (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)

    ))
(add-hook 'python-mode-hook 'lconfig-python-mode)


;; Flymake Python
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pycheckers-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/el-get/pycheckers/pycheckers" (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pycheckers-init)))
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

(eval-after-load "po-mode+"
  '(progn
     (setq po-auto-replace-file-header nil)
     (setq po-auto-replace-revision-date nil)
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
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color) (background dark)) (:background "dark red"))))
 '(flymake-warnline ((((class color) (background dark)) (:background "midnight blue")))))
