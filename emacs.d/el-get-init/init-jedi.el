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
(add-hook 'python-mode-hook 'jedi-mode)


(eval-after-load 'company
  '(progn
     (defun jedi:company-backend (command &optional arg &rest ignored)
       (case command
         (prefix (and (derived-mode-p 'python-mode)
                      buffer-file-name
                      (not (company-in-string-or-comment))
                      (jedi:complete-request)
                      (company-grab-symbol)))
         (candidates
          (mapcar (lambda (e) (plist-get e :word))  jedi:complete-reply))
         (meta
          (let ((doc-string
                 (plist-get (car (remove-if-not
                                  (lambda (e) (string-equal (plist-get e :word) arg))
                                  jedi:complete-reply))
                            :doc)))
            (when doc-string
              (substring doc-string 0 (string-match "\n" doc-string)))))
         (no-cache t)
         (sorted nil)))
     (add-to-list 'company-backends 'jedi:company-backend)))
