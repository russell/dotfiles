;; -*- Mode: Emacs-Lisp -*-

(setq load-path (cons (expand-file-name "~/.emacs.d/el-get/nognus/lisp") load-path))
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
 '(erc-modules (quote (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring services stamp spelling track highlight-nicknames)))
 '(flymake-gui-warnings-enabled nil)
 '(frame-background-mode (quote dark))
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(inhibit-startup-screen t)
 '(ns-alternate-modifier (quote meta))
 '(org-agenda-files (quote ("~/.deft/")))
 '(org-directory "~/.deft/")
 '(org-hide-leading-stars t)
 '(org-mobile-directory "~/public_html/org")
 '(org-mobile-inbox-for-pull "~/.deft/flagged.org")
 '(org-modules (quote (org-bibtex org-docview org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-toc org-wikinodes)))
 '(org-startup-folded (quote content))
 '(org-tag-persistent-alist (quote ((:startgroup) ("WORK" . 119) ("HOME" . 104) (:endgroup) ("READING" . 114) ("COMPUTER" . 99))))
 '(org-todo-keywords (quote ((type "TODO(t)" "STARTED(s)" "WAITING(w)" "APPT(a)" "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)"))))
 '(predictive-dict-autosave nil)
 '(predictive-dict-autosave-on-kill-buffer nil)
 '(predictive-dict-autosave-on-mode-disable nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify))
 '(user-full-name "Russell Sim")
 '(user-mail-address "russell.sim@gmail.com"))


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
(setq ansi-color-names-vector ["black" "tomato" "#8ae234" "#edd400"
			       "#729fcf" "#ad7fa8" "light cyan" "white"])
(setq ansi-term-color-vector [unspecified "black" "tomato" "#8ae234" "#edd400" "#729fcf" "#ad7fa8" "light cyan" "white"])

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
(set-default 'tramp-default-proxies-alist '())
(add-to-list 'tramp-default-proxies-alist
	     '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
	     '("\\.nectar\\.org\\.au" nil nil))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote "localhost") nil nil))

;; follow symlinks to version controlled files
(setq vc-follow-symlinks t)


;; intergrate copy and paste
(setq x-select-enable-clipboard t)

;; Hilight the current line
(global-hl-line-mode 1)
(add-hook 'eshell-mode-hook
	  '(lambda()
	     (set (make-local-variable 'global-hl-line-mode) nil)))
(add-hook 'calendar-mode-hook
	  '(lambda()
	     (set (make-local-variable 'global-hl-line-mode) nil)))
(add-hook 'comint-mode-hook
	  '(lambda()
	     (set (make-local-variable 'global-hl-line-mode) nil)))
(add-hook 'term-mode-hook
	  '(lambda()
	     (set (make-local-variable 'global-hl-line-mode) nil)))
(add-hook 'slime-repl-mode-hook
	  '(lambda()
	     (set (make-local-variable 'global-hl-line-mode) nil)))
(add-hook 'erc-mode-hook
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

(delete-selection-mode t)

; Remember position in buffers
(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package


; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("erc" (mode . erc-mode))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))
	       ("gnus" (or
			(mode . message-mode)
			(mode . mail-mode)
			(mode . gnus-group-mode)
			(mode . gnus-summary-mode)
			(mode . gnus-article-mode)
			(name . "^\\.newsrc-dribble")))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))

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


;; pymacs
(setq pymacs-reload nil) ; change nil to t to force a reload.


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
			    (setq ac-dwim t)))

        (:name bash-completion
               :type git
               :url "https://github.com/szermatt/emacs-bash-completion.git"
	       :features bash-completion
               :post-init (lambda ()
			    (bash-completion-setup)))

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
               :after (lambda ()
			(add-hook 'python-mode-hook
				  '(lambda ()
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

				     (if (or pymacs-reload (not (boundp 'ropePymacs)))
					 (setq ropePymacs (pymacs-load "ropemacs" "rope-"))
				       (message "ropePymacs already loaded")
				       )

				     (require 'tramp-cmds) ;; required for list remote buffers
				     ;; Rope Mode - Only enable when editing local files
				     (when (not (subsetp (list (current-buffer))
							 (tramp-list-remote-buffers)))
				       (ropemacs-mode 1)
				       (setq ropemacs-enable-autoimport t)
				       (with-project-root (rope-open-project
							   (cdr project-details)))
				       (setq ac-sources '(ac-source-rope ac-source-yasnippet)))))))

        (:name pydoc-info
               :type hg
               :url "http://bitbucket.org/jonwaltman/pydoc-info/"
	       :feature pydoc-info)

	(:name python-mode
	       :type git
	       :url "git://github.com/russell/python-mode.git"
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

	(:name yasnippet
	       :website "http://code.google.com/p/yasnippet/"
	       :description "YASnippet is a template system for Emacs."
	       :type git
	       :url "https://github.com/capitaomorte/yasnippet.git"
	       :features "yasnippet"
	       :prepare (lambda ()
			  ;; Set up the default snippets directory
			  ;;
			  ;; Principle: don't override any user settings
			  ;; for yas/snippet-dirs, whether those were made
			  ;; with setq or customize.  If the user doesn't
			  ;; want the default snippets, she shouldn't get
			  ;; them!
			  (unless (or (boundp 'yas/snippet-dirs) (get 'yas/snippet-dirs 'customized-value))
			    (setq yas/snippet-dirs
				  (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets")))))

	       :post-init (lambda ()
			    ;; Trick customize into believing the standard
			    ;; value includes the default snippets.
			    ;; yasnippet would probably do this itself,
			    ;; except that it doesn't include an
			    ;; installation procedure that sets up the
			    ;; snippets directory, and thus doesn't know
			    ;; where those snippets will be installed.  See
			    ;; http://code.google.com/p/yasnippet/issues/detail?id=179
			    (put 'yas/snippet-dirs 'standard-value
				 ;; as cus-edit.el specifies, "a cons-cell
				 ;; whose car evaluates to the standard
				 ;; value"
				 (list (list 'quote
					     (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets")))))
			    (yas/global-mode 1))
	       ;; byte-compile load vc-svn and that fails
	       ;; see https://github.com/dimitri/el-get/issues/200
	       :compile nil)

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

	(:name expand-region
	       :features expand-region
	       :type git
	       :url "git://github.com/magnars/expand-region.el.git"
	       :post-init (lambda ()
			    (global-set-key (kbd "C-@") 'er/expand-region)))

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
			   (autoload 'po-mode "po-mode+"
			     "Major mode for translators to edit PO files" t)
			   ))

	(:name tsql-indent
	       :type emacswiki
	       :features tsql-indent)

	(:name mysql
	       :type emacswiki
	       :features mysql)

	(:name sql-completion
	       :type emacswiki
	       :depends mysql
	       :features sql-completion
	       :post-init (lambda ()
			    (add-hook 'sql-interactive-mode-hook
				  '(lambda ()
				    (define-key sql-interactive-mode-map "\t" 'comint-dynamic-complete)
				    (sql-mysql-completion-init)))))

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
			    (global-set-key [(control x) (?9)] 'sticky-window-keep-window-visible)))

	(:name popup
	       :type git
	       :url "https://github.com/m2ym/popup-el.git")

	(:name popup-kill-ring
	       :type emacswiki
	       :depends (popup pos-tip)
	       :features popup-kill-ring
	       :post-init (lambda ()
			    (global-set-key "\M-y" 'popup-kill-ring)))

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

	(:name js2-mode
	       :type git
	       :description "An improved JavaScript editing mode"
	       :url "https://github.com/mooz/js2-mode.git"
	       :post-init (lambda ()
			    (autoload 'js2-mode "js2-mode" nil t)))

	(:name hideshow-org
	       :features hideshow-org
	       :type git
	       :url "https://github.com/secelis/hideshow-org.git")

	(:name workgroups
	       :description "Workgroups for windows (for Emacs)"
	       :type git
	       :url "https://github.com/tlh/workgroups.el.git"
	       :features "workgroups"
	       :post-init (lambda ()
			    (workgroups-mode 1)
			    ))

	(:name google-contacts
	       :features (google-contacts google-contacts-gnus google-contacts-message)
	       :depends oauth2
	       :type git
	       :url "git://git.naquadah.org/google-contacts.el.git")

	(:name oauth2
	       :features oauth2
	       :type elpa)

	(:name slime
	       :description "Superior Lisp Interaction Mode for Emacs"
	       :type git
	       :module "slime"
	       :info "doc"
	       :features slime
	       :url "https://github.com/emacsmirror/slime.git"
	       :load-path ("." "contrib")
	       :compile (".")
	       :build ((mapcar (lambda (path)
				   (byte-compile-file (concat el-get-dir path)))
				 (list
				  "/slime/contrib/slime-parse.el"
				  "/slime/contrib/slime-fancy-inspector.el"
				  "/slime/contrib/slime-asdf.el"
				  "/slime/contrib/inferior-slime.el"
				  "/slime/contrib/slime-autodoc.el"
				  "/slime/contrib/slime-editing-commands.el"
				  "/slime/contrib/slime-c-p-c.el"
				  "/slime/contrib/slime-repl.el"
				  "/slime/contrib/slime-fuzzy.el"
				  "/slime/contrib/slime-presentations.el"
				  "/slime/contrib/slime-scratch.el"
				  "/slime/contrib/slime-references.el"
				  "/slime/contrib/slime-package-fu.el"
				  "/slime/contrib/slime-fontifying-fu.el"
				  "/slime/contrib/slime-fancy.el"))
		       (list "make -C doc"))
	       :after (lambda ()
			(setq inferior-lisp-program "sbcl --noinform --no-linedit")
			(slime-setup '(inferior-slime slime-fancy slime-asdf))))

	(:name hyperspec-info
	       :description "info lookup for hyperspec"
	       :type http
	       :features hyperspec-info
	       :url "http://www.pentaside.org/code/hyperspec-info.el")
))

(setq my-packages
      (append '(color-theme-tangotango cedet oauth2
       highlight-symbol highlight-parentheses git-emacs
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
       project-root magit fill-column-indicator deft puppet-mode
       markdown-mode breadcrumb sticky-windows expand-region
       emacs-w3m ctags-update hideshow-org bash-completion
       scss-mode slime ac-slime erc twittering-mode multi-term
       erc-highlight-nicknames apache-mode nognus google-contacts)))
(el-get 'sync my-packages)

;; Compile Current Buffer
(defun compile-current-buffer (&optional comint)
  (interactive (list (consp current-prefix-arg)))
   (setq command (concat (eval compile-command)
	      " " (buffer-file-name)))
  (save-some-buffers (not compilation-ask-about-save) nil)
  (setq-default compilation-directory default-directory)
  (compilation-start command comint))
(global-set-key [f6] 'compile-current-buffer)


; Project Config
(setq project-roots
      `(("Python rope project"
	 :root-contains-files (".ropeproject")
         )
	("Python project"
         :root-contains-files ("setup.py")
         )))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
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


;;;; mailto-compose-mail.el (2010-08-15)
;;;; from http://www.emacswiki.org/emacs/MailtoHandler
;;;###autoload
(defun mailto-compose-mail (mailto-url)
  "Parse MAILTO-URL and start composing mail."
  (if (and (stringp mailto-url)
           (string-match "\\`mailto:" mailto-url))
      (progn
        (require 'rfc2368)
        (require 'rfc2047)
        (require 'mailheader)

        (let ((hdr-alist (rfc2368-parse-mailto-url mailto-url))
              (body "")
              to subject
              ;; In addition to To, Subject and Body these headers are
              ;; allowed:
              (allowed-xtra-hdrs '(cc bcc in-reply-to)))

          (with-temp-buffer
            ;; Extract body if it's defined
            (when (assoc "Body" hdr-alist)
              (dolist (hdr hdr-alist)
                (when (equal "Body" (car hdr))
                  (insert (format "%s\n" (cdr hdr)))))
              (rfc2047-decode-region (point-min) (point-max))
              (setq body (buffer-substring-no-properties
                          (point-min) (point-max)))
              (erase-buffer))

            ;; Extract headers
            (dolist (hdr hdr-alist)
              (unless (equal "Body" (car hdr))
                (insert (format "%s: %s\n" (car hdr) (cdr hdr)))))
            (rfc2047-decode-region (point-min) (point-max))
            (goto-char (point-min))
            (setq hdr-alist (mail-header-extract-no-properties)))

          (setq to (or (cdr (assq 'to hdr-alist)) "")
                subject (or (cdr (assq 'subject hdr-alist)) "")
                hdr-alist
                (remove nil (mapcar
                             #'(lambda (item)
                                 (when (memq (car item) allowed-xtra-hdrs)
                                   (cons (capitalize (symbol-name (car item)))
                                         (cdr item))))
                             hdr-alist)))

          (compose-mail to subject hdr-alist nil nil
                        (list (lambda (string)
                                (insert string))
                              body))))
    (compose-mail)))

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

    ;; ctags
    ;;(ctags-update-minor-mode 1)

    ;; hideshow
    (global-set-key (kbd "C-c h") 'hs-org/minor-mode)
    ;;(hs-org/minor-mode)

    (defadvice goto-line (after expand-after-goto-line activate compile)
      "hideshow-expand affected block when using goto-line in a collapsed buffer"
      (save-excursion
	(hs-show-block)))

    ; trim whitespace
    (add-hook 'write-contents-functions
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

    ;;(ac-set-trigger-key "TAB")
    ;;(setq ac-sources '(ac-source-rope ac-source-yasnippet))
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
;(setq auto-mode-alist
;      (cons '("\\.po\\'\\|\\.po\\." . po-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.po$" . flyspell-mode) auto-mode-alist))
;(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)
;(add-hook 'po-mode-hook '(lambda () (flyspell-mode)))

(eval-after-load "po-mode+"
  '(progn
     (setq po-auto-replace-file-header nil)
     (setq po-auto-replace-revision-date nil)
     (setq po-default-file-header "\
msgid \"\"
msgstr \"\"
\"MIME-Version: 1.0\\n\"
\"Content-Type: text/plain; charset=UTF-8\\n\"
\"Content-Transfer-Encoding: 8bit\\n\"
")))
;(eval-after-load "po-mode"
;  '(load "gb-po-mode"))

; RST Mode

(add-hook 'rst-mode-hook '(lambda () (flyspell-mode)))


; XML Modes
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

;(setq auto-mode-alist (cons '("\\.html$" . sgml-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.html\.raw$" . sgml-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.dtml$" . sgml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.html$" . nxml-mode) auto-mode-alist))
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

;; CSS
(add-hook 'css-mode-hook
	  '(lambda ()
	     (add-hook 'write-contents-functions
		       '(lambda()
			  (save-excursion
			    (delete-trailing-whitespace))))))
(add-hook 'css-mode-hook
	  '(lambda ()
	     (css-color-mode t)))

; Lisp
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-mode-hook
	  (lambda ()
	    (add-hook 'write-contents-functions
		      '(lambda()
			 (save-excursion
			   (delete-trailing-whitespace))))))
(add-hook 'slime-mode-hook
	  (lambda ()
	    (add-hook 'write-contents-functions
		      'check-parens)))

(add-hook 'inferior-lisp-mode-hook (lambda () (auto-complete-mode 1)))
;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

; elisp

(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()
	     (add-hook 'write-contents-functions
		       '(lambda()
			  (save-excursion
			    (delete-trailing-whitespace))))))
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (eldoc-mode)))
; could be bad, will not let you save at all, until you correct the error
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (add-hook 'write-contents-functions
		      'check-parens)))

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
          (shell-command (concat "cd " dn " && git push & true")))
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
          (shell-command (concat "cd " dn " && git pull & true")))
        dn)
       (setq autocommit-dir-set (cons dn autocommit-dir-set)))))

(defun autocommit-after-save-hook ()
  "After-save-hook to 'git add' the modified file and schedule a commit and push in the idle loop."
  (let ((fn (buffer-file-name)))
    (message "git adding %s" fn)
    (shell-command (mapconcat 'shell-quote-argument (list "git" "add" fn) " "))
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

;;(add-hook 'find-file-hook 'dustin-visiting-a-file)


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

(setq org-completion-use-ido t)

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
       (format "%s -eR --extra=+q" path-to-ctags))))


(put 'narrow-to-region 'disabled nil)

;; Shell

(defun add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification
	       '(:propertize (" " default-directory " ") face dired-directory)))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)

;; Term
(add-hook 'term-mode-hook (lambda ()
                            (define-key term-raw-map (kbd "C-y") 'term-paste)))
(add-hook 'term-mode-hook 'add-mode-line-dirtrack)


;; Sudo

(defun sudo-edit-current-file ()
  (interactive)
  (find-alternate-file
   (concat "/sudo:root@localhost:"
	   (buffer-file-name (current-buffer)))))

;;
;; twitter
;;
(setq twittering-use-master-password t)
(setq twittering-icon-mode t)                ; Show icons
(setq twittering-timer-interval 300)         ; Update your timeline each 300 seconds (5 minutes)
(setq twittering-url-show-status nil)        ; Keeps the echo area from showing all the http processes


;; ERC

(load "~/.ercpass")

(require 'erc-services)
(erc-services-mode 1)

(setq erc-max-buffer-size 30000)
(add-hook 'erc-mode-hook
	  '(lambda ()
	     (erc-truncate-mode t)))

(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-identify-mode 'autodetect)
(defun start-irc ()
  "Connect to IRC."
  (interactive)
  (erc-tls :server "irc.oftc.net" :port 6697
	   :nick "arrsim" :full-name "Russell Sim"
	   :password oftc-pass)
  (erc-tls :server "irc.freenode.net" :port 6697
	   :nick "arrsim" :full-name "Russell Sim"
	   :password freenode-pass)
  (setq erc-autojoin-channels-alist
	'(("freenode.net" "#emacs" "#python"
	   "#twisted" "#twisted.web" "#pylons"
	   "#pyramid" "#openstack" "#lisp" "#lispcafe")
	  ("oftc.net" "#debian" "#debian-mentors"
	   "#debian-python" "#debian-gname"))))

(setq erc-autojoin-channels-alist '())
