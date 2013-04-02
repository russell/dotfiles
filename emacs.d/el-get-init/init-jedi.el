(custom-set-variables
 '(jedi:goto-follow t)
 '(jedi:key-complete (kbd ""))
 '(jedi:key-goto-definition (kbd "M-."))
 '(jedi:setup-keys t))

;; Auto complete
(add-hook 'python-mode-hook
          '(lambda ()
             (setq ac-sources '(ac-source-jedi-direct
                                ac-source-yasnippet))))
