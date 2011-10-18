;; -*- Mode: Emacs-Lisp -*-

(add-to-list 'load-path "~/.emacs.d/")

;; disable the toolbar, scroll bar and menu bar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


; set font
(set-default-font "DejaVu Sans Mono:pixelsize=13:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true")
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono:pixelsize=13:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true"))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-completion-syntax-alist (quote (accept . word)))
 '(completion-auto-show (quote completion-show-menu))
 '(completion-auto-show-delay 0)
 '(deft-auto-save-interval 30.0)
 '(ecb-options-version "2.40")
 '(elmo-localdir-folder-path "~/Mail")
 '(elscreen-tab-display-control nil)
 '(frame-background-mode (quote dark))
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(inhibit-startup-screen t)
 '(ns-alternate-modifier (quote meta))
 '(org-agenda-files (quote ("~/.deft/")))
 '(org-directory "~/.deft/")
 '(org-mobile-inbox-for-pull "~/.deft/flagged.org")
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-toc org-wikinodes)))
 '(org-startup-folded (quote content))
 '(org-tag-persistent-alist (quote ((:startgroup) ("WORK" . 119) ("HOME" . 104) (:endgroup) ("READING" . 114) ("COMPUTER" . 99))))
 '(org-todo-keywords (quote ((type "TODO(t)" "STARTED(s)" "WAITING(w)" "APPT(a)" "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)"))))
 '(org-mobile-directory "~/public_html/mobile.org")
 '(predictive-dict-autosave nil)
 '(predictive-dict-autosave-on-kill-buffer nil)
 '(predictive-dict-autosave-on-mode-disable nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify))
 '(user-mail-address "russell.sim@gmail.com")
 '(user-full-name "Russell Sim"))


; el-get
(if (file-exists-p "~/.emacs.d/el-get/el-get")
    (add-to-list 'load-path "~/.emacs.d/el-get/el-get"))
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))


(defun add-to-pythonpath (path)
  "Adds a directory to the PYTHONPATH environment
variable. Automatically applies expand-file-name to `path`."
  (setenv "PYTHONPATH"
    (concat (expand-file-name path) ":" (getenv "PYTHONPATH"))))


; title format
(setq frame-title-format "%b - emacs")


;; Terminal color config
(setq ansi-term-color-vector [unspecified "black" "tomato" "#8ae234" "#edd400"
					  "#729fcf" "#ad7fa8" "light cyan" "white"])
(setq term-default-bg-color "#2e3434")
(setq term-default-fg-color "#eeeeec")


; recompile hot key
(global-set-key (kbd "<f9>") 'recompile)


(setq ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-dictionary "english")
(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem


;; Dynamic Abbreviations C-<tab>
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)


; TRAMP
(setq password-cache-expiry 1000)


;; follow symlinks to version controlled files
(setq vc-follow-symlinks t)


;; Hilight the current line
(global-hl-line-mode 1)
(add-hook 'term-mode-hook
	  '(lambda()
	     (set (make-local-variable 'global-hl-line-mode) nil)))
(add-hook 'eshell-mode-hook
	  '(lambda()
	     (set (make-local-variable 'global-hl-line-mode) nil)))
(add-hook 'calendar-mode-hook
	  '(lambda()
	     (set (make-local-variable 'global-hl-line-mode) nil)))

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)


; winner-mode provides C-<left> to get back to previous window layout
(winner-mode 1)


;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)


; Remember position in buffers
(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package


; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)


; IDO
(require 'ido)
(ido-mode)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t) ;; enable fuzzy matching


; store temporary files in home directory
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))


;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)


;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
(if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)


; Flymake
(setq flymake-start-syntax-check-on-find-file nil)


; Scrolling
;(require 'smooth-scrolling)
;; scroll one line at a time (less "jumpy" than defaults)
;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time


; Remember Recent Files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


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


;; custom keybindings
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)


; el-get configuration
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(setq el-get-verbose t)
(setq el-get-sources

      '((:name magit
               :after (lambda () (global-set-key (kbd "C-x C-z") 'magit-status)))

        (:name project-root
	       :type git
	       :url "https://github.com/emacsmirror/project-root.git"
	       :features project-root)

	(:name auto-complete
	       :website "http://cx4a.org/software/auto-complete/"
	       :description "The most intelligent auto-completion extension."
	       :type git
	       :url "http://github.com/m2ym/auto-complete.git"
	       :load-path "."
	       :post-init (lambda ()
			    (require 'auto-complete)
			    (add-to-list 'ac-dictionary-directories (expand-file-name "dict" pdir))
			    (require 'auto-complete-config)
			    (ac-config-default)

			    ;; custom keybindings to use tab, enter and up and down arrows
			    (define-key ac-complete-mode-map "\t" 'ac-expand)
			    (define-key ac-complete-mode-map "\r" 'ac-complete)
			    (define-key ac-complete-mode-map "\M-n" 'ac-next)
			    (define-key ac-complete-mode-map "\M-p" 'ac-previous)

			    ;; Live completion with auto-complete
			    ;; (see http://cx4a.org/software/auto-complete/)
			    (require 'auto-complete-config nil t)
			    ;; Do What I Mean mode
			    (setq ac-dwim t)
			    ))

	(:name autopair
	       :website "http://code.google.com/p/autopair/"
	       :description "Autopair is an extension to the Emacs text editor that automatically pairs braces and quotes."
	       :type http
	       :url "http://autopair.googlecode.com/svn/trunk/autopair.el"
	       :features autopair
	       :after (lambda ()
			(require 'autopair)
			(setq autopair-blink t)
			(add-hook 'python-mode-hook
				  '(lambda ()
				     (autopair-mode)))
			(add-hook 'emacs-lisp-mode-hook
				  '(lambda ()
				     (autopair-mode)))
			))

	(:name cedet
	       :website "http://cedet.sourceforge.net/"
	       :description "CEDET is a Collection of Emacs Development Environment Tools written with the end goal of creating an advanced development environment in Emacs."
	       :type bzr
	       :url "bzr://cedet.bzr.sourceforge.net/bzrroot/cedet/code/trunk"
	       :build ("touch `find . -name Makefile`" "make")
	       :build/windows-nt ("echo #!/bin/sh > tmp.sh & echo touch `/usr/bin/find . -name Makefile` >> tmp.sh & echo make FIND=/usr/bin/find >> tmp.sh"
				  "sed 's/^M$//' tmp.sh  > tmp2.sh"
				  "sh ./tmp2.sh" "rm ./tmp.sh ./tmp2.sh")
	       :load-path ("./common" "speedbar"))

        (:name django-mode
               :type git
               :url "https://github.com/myfreeweb/django-mode.git")

        (:name pymacs
               :type git
               :url "http://github.com/pinard/Pymacs.git"
               :build ("make")
               :after (lambda ()
                        (add-to-pythonpath (concat el-get-dir "pymacs"))))

        (:name rope
               :type hg
               :url "http://bitbucket.org/agr/rope/"
               :after (lambda ()
                        (add-to-pythonpath (concat el-get-dir "rope/rope"))))

        (:name ropemode
               :type hg
               :url "http://bitbucket.org/agr/ropemode/"
               :after (lambda ()
                        (add-to-pythonpath (concat el-get-dir "ropemode/ropemode"))))

        (:name ropemacs
               :type hg
               :url "http://bitbucket.org/agr/ropemacs/"
	       :depends (pymacs rope ropemode auto-complete)
	       :depends (pymacs rope ropemode auto-complete)
               :after (lambda ()
			(add-hook 'python-mode-hook '(lambda ()
                        (add-to-pythonpath (concat el-get-dir "ropemacs/ropemacs"))
                        (setq ropemacs-local-prefix "C-c C-p")
                        (require 'pymacs)
			(setq pymacs-load-path '( "~/.emacs.d/el-get/rope"
						  "~/.emacs.d/el-get/ropemode"
						  "~/.emacs.d/el-get/ropemacs"
						  "~/.emacs.d/el-get/python-mode"))

			;; Stops from erroring if there's a syntax err
			(setq ropemacs-codeassist-maxfixes 3)
			(setq ropemacs-guess-project t)
			(setq ropemacs-enable-autoimport t)
                        (pymacs-load "ropemacs" "rope-")

			;; Rope Mode - Only enable when editing local files
			(when (not (subsetp (list (current-buffer))
					    (tramp-list-remote-buffers)))
			  (ropemacs-mode 1)
			  (setq ropemacs-enable-autoimport t)
			  (with-project-root (rope-open-project
					      (cdr project-details)))
			  (setq ac-sources '(ac-source-rope ac-source-yasnippet)))
			))))

	(:name python-mode
	       :type emacsmirror
	       :features (python-mode)
	       :depends pymacs
	       :compile nil
	       :post-init (lambda ()
			    (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
			    (add-to-list 'interpreter-mode-alist '("python" . python-mode))
			    (autoload 'python-mode "python-mode" "Python editing mode." t)
			    (define-key py-mode-map [f4] 'speedbar-get-focus)
			    ))

        (:name ipython
	       :depends (python-mode))

	(:name color-theme
	       :type bzr
	       :options nil
	       :url "bzr://bzr.savannah.nongnu.org/color-theme/trunk"
               :load "color-theme.el"
               :features "color-theme"
	       :post-init (lambda ()
			    (color-theme-initialize)
			    (setq color-theme-is-global t)
			    (setq color-theme-is-cumulative t)
			    (setq color-theme-load-all-themes nil)))


	(:name color-theme-tangotango
	       :type git
	       :depends (color-theme)
	       :features color-theme-tangotango
	       :url "git@github.com:russell/color-theme-tangotango.git"
	       :post-init (lambda ()
			    (color-theme-tangotango)))

	(:name highlight-indentation
	       :features highlight-indentation
	       :type git
	       :url "https://github.com/antonj/Highlight-Indentation-for-Emacs")

	(:name flymake-python
	       :type git
	       :url "git@github.com:russell/flymake-python.git")

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

	(:name dirvars
	       :features dirvars
	       :type emacswiki)

	(:name ctags-update
	       :features ctags-update
	       :type emacswiki)

	(:name sr-speedbar
	       :features sr-speedbar
	       :depends (cedet)
	       :before (lambda ()
			 (require 'speedbar))
	       :type emacswiki)

	(:name sticky-windows
	       :features sticky-windows
	       :type emacswiki
               :post-init (lambda ()
			    (global-set-key [(control x) (?0)] 'sticky-window-delete-window)
			    (global-set-key [(control x) (?1)] 'sticky-window-delete-other-windows)
			    ; In addition, `sticky-window-keep-window-visible' might be bound to the currently unused C-x 9 key binding:
			    (global-set-key [(control x) (?9)] 'sticky-window-keep-window-visible)
			    ))

	(:name popup
	       :type git
	       :url "https://github.com/m2ym/popup-el.git")

	(:name popup-kill-ring
	       :type emacswiki
	       :depends (popup pos-tip)
	       :features popup-kill-ring
	       :post-init (lambda ()
			    (global-set-key "\M-y" 'popup-kill-ring)
			    ))

	(:name predictive
	       :description "The Emacs Predictive Completion package adds a new minor-mode to the GNU Emacs editor."
	       :type git
	       :depends (cedet)
	       :url "https://github.com/emacsmirror/predictive.git"
	       :features predictive)

	(:name smex
	       :description "M-x interface with Ido-style fuzzy matching."
	       :type git
	       :url "http://github.com/nonsequitur/smex.git"
	       :features smex
	       :post-init (lambda ()
			    (smex-initialize)
			    (global-set-key (kbd "M-x") 'smex)
			    (global-set-key (kbd "M-X") 'smex-major-mode-commands)
			    (global-set-key (kbd "C-c M-x") 'smex-update-and-run)
			    (global-set-key "\C-x\C-m" 'smex)))

	(:name active-menu
	       :website "http://www.emacswiki.org/emacs/ActiveMenu"
	       :description "Active Menu toggles the display of the menu bar automatically when the mouse comes close to it. Otherwise you get one more line of code."
	       :type git
	       :url "https://github.com/emacsmirror/active-menu.git"
	       :features "active-menu")

	(:name fill-column-indicator
	       :type git
	       :url "https://github.com/alpaker/Fill-Column-Indicator.git"
	       :features "fill-column-indicator")

	(:name deft
	       :description "Deft is an Emacs mode for quickly browsing, filtering, and editing directories of plain text notes, inspired by Notational Velocity."
	       :type http
	       :url "http://jblevins.org/projects/deft/deft.el"
	       :features deft
	       :post-init (lambda ()
			    (setq deft-text-mode 'org-mode)
			    (setq deft-extension "org")
			    (global-set-key [f1] 'deft)
			    ))

	(:name muse
	       :description "An authoring and publishing tool for Emacs"
	       :type git
	       :url "https://github.com/alexott/muse.git"
	       :load-path ("./lisp")
	       :build `(,(concat "make EMACS=" el-get-emacs))
	       :autoloads "muse-autoloads"
	       :post-init (lambda ()
			    (add-hook 'muse-mode-hook
				      '(lambda ()
					 (color-theme-tangotango)))
			    ))

	(:name ical2org
	       :type git
	       :url "https://github.com/cofi/ical2org.git")

	(:name breadcrumb
	       :website "http://breadcrumbemacs.sourceforge.net/"
	       :description "Breadcrumb is an add-on module for Emacs that allows you to set a series of quick bookmarks in the file buffers, and jump back to them quickly."
	       :type http
	       :url "http://downloads.sourceforge.net/project/breadcrumbemacs/Breadcrumb%20for%20Emacs/1.1.3/breadcrumb-1.1.3.zip"
	       :build ("unzip breadcrumb-1.1.3.zip")
	       :before (lambda ()
			 (require 'inversion))
	       :post-init (lambda ()
			    (require 'breadcrumb)
			    (global-set-key [?\S-\ ] 'bc-set) ;; Shift-SPACE for set bookmark
			    (global-set-key [(meta j)] 'bc-previous) ;; M-j for jump to previous
			    (global-set-key [(shift meta j)] 'bc-next) ;; Shift-M-j for jump to next
			    (global-set-key [(meta up)] 'bc-local-previous) ;; M-up-arrow for local previous
			    (global-set-key [(meta down)] 'bc-local-next) ;; M-down-arrow for local next
			    (global-set-key [(control c)(j)] 'bc-goto-current) ;; C-c j for jump to current bookmark
			    (global-set-key [(control x)(meta j)] 'bc-list) ;; C-x M-j for the bookmark menu list
			    ))

	(:name elscreen
	       :type http-tar
	       :features elscreen
	       :options ("xzf")
	       :url "ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/elscreen-1.4.6.tar.gz")
))

(setq my-packages
      (append '(color-theme-tangotango rainbow-mode cedet
       highlight-symbol highlight-parentheses gravatar git-emacs
       git-blame mo-git-blame virtualenv flymake-point
       flymake-fringe-icons folding js2-mode js-comint json
       fic-ext-mode eol-conversion doxymacs dired-plus diff-git
       clevercss auto-complete auto-complete-clang auctex
       active-menu fringe-helper csv-mode apel el-get cssh
       switch-window vkill google-maps nxhtml xcscope yasnippet
       tidy rainbow-delimiters org-mode android-mode rst-mode
       pylookup python-pep8 smex popup-kill-ring sr-speedbar
       dirvars po-mode+ po-mode pycheckers flymake-python
       highlight-indentation ipython python-mode ropemacs
       ropemode rope pymacs django-mode autopair auto-complete
       project-root magit fill-column-indicator deft
       gnus-gravatar markdown-mode breadcrumb sticky-windows
       emacs-w3m ctags-update)))
(el-get 'sync my-packages)

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


(defun project-root-compile ()
  "Compile the project, using the project root as the cwd."
  (interactive)
  (with-project-root (compile)))


(defun lconfig-python-mode ()
  (progn

    (flyspell-prog-mode)

    ;; Only spaces, no tabs
    (setq indent-tabs-mode nil)

    ;; Always end a file with a newline
    (setq require-final-newline nil)

    ;; Auto Fill
    ;;(python-auto-fill-comments-only)

    ;; ctags
    (ctags-update-minor-mode 1)

    ; trim whitespace
    (add-hook 'local-write-file-hooks
	      '(lambda()
		 (save-excursion
		   (delete-trailing-whitespace))))

    (define-key py-mode-map [(meta q)] 'py-fill-paragraph)

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


; ropemacs Integration with auto-completion
(defun ac-nropemacs-setup ()

  (defun ac-ropemacs-candidates ()
    (mapcar (lambda (completion)
	      (concat ac-prefix completion))
	    (rope-completions)))

  (ac-define-source nropemacs
    '((candidates . ac-ropemacs-candidates)
      (symbol . "p")))

  (ac-define-source nropemacs-dot
    '((candidates . ac-ropemacs-candidates)
      (symbol . "p")
      (prefix . c-dot)
      (requires . 0)))
  (setq ac-sources (append '(ac-source-nropemacs
                             ac-source-nropemacs-dot) ac-sources)))

(add-hook 'rope-open-project-hook 'ac-nropemacs-setup)


;; Flymake Python
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pycheckers-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-with-folder-structure))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/el-get/flymake-python/pyflymake.py" (list local-file))))

   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pycheckers-init)))

(load-library "flymake-cursor")
(global-set-key [f2] 'flymake-goto-prev-error)
(global-set-key [f3] 'flymake-goto-next-error)


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


; Flymake XML
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


;Flymake latex
(defun flymake-get-tex-args (file-name)
    (list "pdflatex" (list "-file-line-error"
			   "-draftmode"
			   "-interaction=nonstopmode"
			   file-name)))

; Markdown Mode
(defun lconfig-markdown-mode ()
  (progn
    (auto-fill-mode)
    (flyspell-mode)
    ))
(add-hook 'markdown-mode-hook 'lconfig-markdown-mode)


;; Automatically add, commit, and push when files change.
;; https://gist.github.com/449668 && https://gist.github.com/397971
(defvar autocommit-dir-set '()
  "Set of directories for which there is a pending timer job")

(defun autocommit-schedule-commit (dn)
  "Schedule an autocommit (and push) if one is not already scheduled for the given dir."
  (if (null (member dn autocommit-dir-set))
      (progn
       (run-with-idle-timer
        10 nil
        (lambda (dn)
          (setq autocommit-dir-set (remove dn autocommit-dir-set))
          (message (concat "Committing org files in " dn))
          (shell-command (concat "cd " dn " && git commit -m 'Updated org files.'"))
          (shell-command (concat "cd " dn " && git push & /usr/bin/true")))
        dn)
       (setq autocommit-dir-set (cons dn autocommit-dir-set)))))

(defun autocommit-schedule-pull (dn)
  "Schedule a pull if one is not already scheduled for the given dir."
  (if (null (member dn autocommit-dir-set))
      (progn
       (run-with-idle-timer
        10 nil
        (lambda (dn)
          (setq autocommit-dir-set (remove dn autocommit-dir-set))
          (shell-command (concat "cd " dn " && git pull & /usr/bin/true")))
        dn)
       (setq autocommit-dir-set (cons dn autocommit-dir-set)))))

(defun autocommit-after-save-hook ()
  "After-save-hook to 'git add' the modified file and schedule a commit and push in the idle loop."
  (let ((fn (buffer-file-name)))
    (message "git adding %s" fn)
    (shell-command (concat "git add " (shell-quote-argument fn)))
    (autocommit-schedule-commit (file-name-directory fn))))

(defun autocommit-setup-save-hook ()
  "Set up the autocommit save hook for the current file."
  (interactive)
  (message "Set up autocommit save hook for this buffer.")
  (add-hook 'after-save-hook 'autocommit-after-save-hook nil t))

;;
;; Integration
;;

(defun dustin-visiting-a-file ()
  (let* ((fn (buffer-file-name))
         (dn (file-name-directory fn)))
    (if (equal dn (expand-file-name "~/org/"))
        (progn
          (message "Setting up local hook for %s (in %s)"
                   (file-name-nondirectory fn) dn)
          (autocommit-setup-save-hook)))))

(add-hook 'find-file-hook 'dustin-visiting-a-file)


;; Deft mode hook
(defun deft-sync-pull ()
  (let* ((dn deft-directory))
    (progn
      (message "schedualed pull for %s" dn)
      (autocommit-schedule-pull dn))))

(add-hook 'deft-mode-hook 'deft-sync-pull)


; Org Mode
(defun lconfig-org-mode ()
  (progn
    (auto-fill-mode)
    (flyspell-mode)
    (autocommit-setup-save-hook)
    ))
(add-hook 'org-mode-hook 'lconfig-org-mode)


;;
;; Google Contact Sync
;;
(setq google-contacts-user "russell.sim@gmail.com")
(setq google-contacts-code-directory "~/.emacs.d/el-get/google-contacts/code")
(setq google-contacts-directory "~/tmp")
(setq google-contacts-auto-update t)

;;
;; etags
;;
(setq path-to-ctags "ctags")

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name))))

(defun project-root-create-tags ()
  "Create tags file using the curret project root."
  (interactive)
  (with-project-root
      (shell-command
       (format "%s -eR" path-to-ctags))))
