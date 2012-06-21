;; el-get
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

;; pymacs
(setq pymacs-reload nil) ; change nil to t to force a reload.

;; el-get configuration
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
                        (setq autopair-blink t)))

        (:name cedet
               :website "http://cedet.sourceforge.net/"
               :description "CEDET is a Collection of Emacs Development Environment Tools written with the end goal of creating an advanced development environment in Emacs."
               :type git
               :url "git://git.randomsample.de/cedet.git"
               :build ("touch `find . -name Makefile`" "make")
               :build/windows-nt ("echo #!/bin/sh > tmp.sh & echo touch `/usr/bin/find . -name Makefile` >> tmp.sh & echo make FIND=/usr/bin/find >> tmp.sh"
                                  "sed 's/^M$//' tmp.sh  > tmp2.sh"
                                  "sh ./tmp2.sh" "rm ./tmp.sh ./tmp2.sh")
               )

        (:name django-mode
               :type git
               :url "https://github.com/myfreeweb/django-mode.git")

        (:name pymacs
               :type git
               :url "http://github.com/pinard/Pymacs.git"
               :features pymacs
               :build ("make")
               :post-init (lambda ()
                            (add-to-pythonpath (concat el-get-dir "pymacs"))
                            (unless pymacs-load-path
                              (setq pymacs-load-path (list (concat el-get-dir "pymacs"))))))

        (:name rope
               :type hg
               :url "http://bitbucket.org/agr/rope/"
               :depends (pymacs)
               :after (lambda ()
                        (add-to-list 'pymacs-load-path
                                     (concat el-get-dir "rope"))))

        (:name ropemode
               :type hg
               :url "http://bitbucket.org/agr/ropemode/"
               :depends (pymacs)
               :after (lambda ()
                        (add-to-list 'pymacs-load-path
                                     (concat el-get-dir "ropemode"))))

        (:name ropemacs
               :type hg
               :url "http://bitbucket.org/agr/ropemacs/"
               :depends (pymacs rope ropemode auto-complete)
               :after (lambda ()
                        (add-to-list 'pymacs-load-path (concat el-get-dir "ropemacs"))
                        (add-hook 'python-mode-hook
                                  '(lambda ()
                                     (setq ropemacs-local-prefix "C-c C-p")

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
                                                                  ac-source-nropemacs-dot) ac-sources))
                                       )))))

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
                            (autoload 'python-mode "python-mode" "Python editing mode." t)))

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

        (:name idomenu
               :type emacswiki
               :features idomenu)

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
               :type git
               :url "https://github.com/jixiuf/helm-etags-plus")

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

        (:name json
               :description "JavaScript Object Notation parser / generator"
               :type http
               :url "http://cvs.savannah.gnu.org/viewvc/*checkout*/emacs/lisp/json.el?root=emacs"
               :features json)

        (:name fill-column-indicator
               :type git
               :url "https://github.com/alpaker/Fill-Column-Indicator.git"
               :features "fill-column-indicator")

        (:name artbollocks-mode
               :type git
               :url "git://gitorious.org/robmyers/scripts.git"
               :features "artbollocks-mode")

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


        (:name highlight-sexp
               :features highlight-sexp
               :type git
               :url "git://github.com/daimrod/highlight-sexp.git")

        (:name oauth2
               :features oauth2
               :type elpa)

        (:name icicles
               :type http-tar
               :options ("xzf")
               :url "http://www.emacswiki.org/emacs/download/Icicles.tar.gz"
               :library icicles :features icicles
               :autoloads nil :post-init (lambda () (icy-mode)))

        (:name recover-buffers
               :features recover-buffers
               :type darcs
               :url "http://porkmail.org/elisp/recover-buffers/")

        (:name slime
               :description "Superior Lisp Interaction Mode for Emacs"
               :type git
               :module "slime"
               :info "doc"
               :features slime
               :url "https://github.com/emacsmirror/slime.git"
               :load-path ("." "contrib")
               :compile (".")
               :build (list "make -C doc"))

        (:name hyperspec-info
               :description "info lookup for hyperspec"
               :type http
               :features hyperspec-info
               :url "http://www.pentaside.org/code/hyperspec-info.el")

        (:name anything
               :website "http://www.emacswiki.org/emacs/Anything"
               :description "Open anything / QuickSilver-like candidate-selection framework"
               :type git
               :url "http://repo.or.cz/r/anything-config.git"
               :load-path ("." "extensions")
               :depends (cedet)
               :features anything
               :after (lambda ()
                        (require 'anything-config)))

        (:name restclient-mode
               :type git
               :features restclient
               :url "git://github.com/pashky/restclient.el.git")

        (:name openstack-mode
               :type git
               :features openstack-mode
               :url "git@github.com:russell/openstack-mode.git")

        (:name jabber
               :type git
               :features jabber-autoloads
               :url "git://emacs-jabber.git.sourceforge.net/gitroot/emacs-jabber/emacs-jabber")

        (:name nognus
               :description "A newsreader for GNU Emacs"
               :type git
               :url "git@github.com:russell/gnus.git"
               :build ("./configure" "make")
               :build/windows-nt `(,(concat "\"make.bat " invocation-directory "\""))
               :build/darwin `(,(concat "./configure --with-emacs=" el-get-emacs) "make")
               :info "texi"
               :load-path ("lisp")
               :autoloads nil
               :features gnus-load)

        (:name auto-capitalize
               :type emacswiki
               :website "http://www.emacswiki.org/emacs/auto-capitalize.el"
               :features auto-capitalize)

	(:name apel
	       :website "http://www.kanji.zinbun.kyoto-u.ac.jp/~tomo/elisp/APEL/"
	       :description "APEL (A Portable Emacs Library) is a library to support to write portable Emacs Lisp programs."
	       :type git
	       :module "apel"
	       :url "git://github.com/emacsmirror/apel.git"
	       :build
	       (mapcar
		(lambda (target)
		  (list el-get-emacs
			(split-string "-batch -q -no-site-file -l APEL-MK -f")
			target
			"prefix" "site-lisp" "site-lisp"))
		'("compile-apel" "install-apel"))
	       :load-path ("site-lisp/apel" "site-lisp/emu"))

        ))


(setq my-packages
      (append '(cedet color-theme-tangotango oauth2
       highlight-symbol highlight-parentheses git-emacs git-blame
       mo-git-blame virtualenv flymake-point flymake-fringe-icons
       folding js2-mode js-comint json fic-ext-mode dired+
       eol-conversion doxymacs dired-plus diff-git clevercss
       auto-complete auto-complete-clang auctex active-menu
       fringe-helper csv-mode apel el-get cssh switch-window
       vkill google-maps nxhtml xcscope yasnippet tidy bookmark+
       recover-buffers rainbow-delimiters org-mode android-mode
       rst-mode pylookup python-pep8 smex popup-kill-ring
       sr-speedbar dirvars po-mode+ po-mode pycheckers redshank
       flymake-python hyperspec-info highlight-indentation
       ipython python-mode ropemacs ropemode rope pymacs
       django-mode autopair auto-complete project-root magit
       fill-column-indicator deft puppet-mode markdown-mode
       sticky-windows expand-region emacs-w3m paredit
       git-commit-mode ctags-update hideshow-org bash-completion
       scss-mode slime ac-slime erc idomenu twittering-mode
       multi-term yaml-mode erc-highlight-nicknames apache-mode
       nognus openstack-mode artbollocks-mode google-contacts
       highlight-sexp mailcrypt restclient-mode ace-jump-mode
       auto-capitalize)))
(el-get 'sync my-packages)
