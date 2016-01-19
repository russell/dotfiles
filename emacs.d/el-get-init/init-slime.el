;;; Code:

(require 'slime)

(setq-default slime-lisp-implementations
              '((sbcl ("~/.cim/bin/sbcl"))
                (clisp ("~/.cim/bin/clisp"))
                (ccl ("~/.cim/bin/ccl"))
                (ecl ("~/.cim/bin/ecl"))))

(setq inferior-lisp-program "lisp")

(defun rs/slime-ccl ()
  (interactive)
  (slime 'ccl))

(provide 'init-slime)

;;; init-helm.el ends here
