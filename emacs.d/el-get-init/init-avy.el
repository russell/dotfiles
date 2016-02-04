
(eval-when-compile
 (require 'use-package))

;;; Code:

(use-package avy
  :config
  (setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
  :bind
  ("C-'" . avy-goto-word-1))

(provide 'init-avy)

;;; init-avy.el ends here
