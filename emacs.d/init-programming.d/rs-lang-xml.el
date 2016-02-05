
; Flymake XML
(add-hook 'xml-mode-hook 'flycheck-mode)

(eval-after-load "html-mode"
  '(progn
     (add-hook 'html-mode-hook 'flyspell-mode)
     ;; diff hl mode
     (add-hook 'html-mode-hook 'diff-hl-mode)

     ;; Delete whitespace on save.
     (add-hook 'html-mode-hook
               '(lambda ()
                  (add-hook 'write-contents-functions
                            'delete-trailing-whitespace)))))
