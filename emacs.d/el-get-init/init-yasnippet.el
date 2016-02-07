
(eval-when-compile
  (require 'cl)
  (require 'use-package))

(require 'el-get)

;;; Code:

(use-package yasnippet
  :config
  (setq yas/root-directory "~/.emacs.d/snippets")
  (loop for dir in `("~/.emacs.d/snippets"
                     ,(concat (file-name-as-directory el-get-dir)
                              (file-name-as-directory "yasnippet")
                              "snippets"))
        do (yas-load-directory dir))

  (set-default 'yas-dont-activate
             (lambda ()
               (or (minibufferp)
                   (member major-mode '(erc-mode)))))

  (yas-global-mode)
  (yas-reload-all))


(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
