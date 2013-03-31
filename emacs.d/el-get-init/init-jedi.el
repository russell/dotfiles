
;; Auto complete
(add-hook 'python-mode-hook
          '(lambda ()
             (setq ac-sources '(ac-source-jedi-direct
                                ac-source-yasnippet))))
