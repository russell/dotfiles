
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package slime
  :defer t
  :config
  (setq inferior-lisp-program "lisp")
  (setq-default slime-lisp-implementations
                '((sbcl ("~/.cim/bin/sbcl"))
                  (clisp ("~/.cim/bin/clisp"))
                  (ccl ("~/.cim/bin/ccl"))
                  (ecl ("~/.cim/bin/ecl"))))
  (use-package slime-fiveam))

(defun rs/slime-ccl ()
  (interactive)
  (slime 'ccl))

(provide 'init-slime)
;;; init-slime.el ends here
