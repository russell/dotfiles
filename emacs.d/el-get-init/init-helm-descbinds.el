
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package helm-descbinds
  :defer t
  :init
  (fset 'describe-bindings #'helm-descbinds))

(provide 'init-helm-descbinds)
;;; init-helm-descbinds.el ends here
