
;;; Code:
(if (file-exists-p "~/.emacs.d/el-get/el-get")
    (add-to-list 'load-path "~/.emacs.d/el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(package-initialize)

;; el-get configuration
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(setq el-get-verbose t)
(setq el-get-user-package-directory "~/.emacs.d/el-get-init/")

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; Install use-package first.  It's possibly needed by all packages
;; for configuration.
(el-get-bundle 'use-package)
(el-get-bundle 'cedet)
(el-get-bundle 'org-mode)
(el-get-bundle 'nognus)

(provide 'rs-el-get)
;;; rs-el-get.el ends here
