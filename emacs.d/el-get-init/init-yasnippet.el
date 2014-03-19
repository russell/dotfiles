
;;; Code:

(require 'yasnippet)

(yas-global-mode)

(setq yas/root-directory "~/.emacs.d/snippets")
(loop for dir in `("~/.emacs.d/snippets"
                   ,(concat (file-name-as-directory el-get-dir)
                           (file-name-as-directory "yasnippet")
                           "snippets"))
      do (yas/load-directory dir))
(yas/reload-all)

(set-default 'yas-dont-activate
             (lambda ()
               (or (minibufferp)
                   (member major-mode '(erc-mode)))))

;;; init-yasnippet.el ends here
