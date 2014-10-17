(setq load-path (cons (expand-file-name "~/.emacs.d/el-get/org-mode/") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/el-get/org-mode/lisp") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/el-get/org-mode/contrib/lisp") load-path))

(load-theme 'adwaita)

(load-file (expand-file-name "~/.emacs.d/el-get/org-mode/lisp/org-loaddefs.el"))

(require 'ox)
