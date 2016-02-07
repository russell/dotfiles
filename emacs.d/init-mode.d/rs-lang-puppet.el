
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

(use-package puppet-mode
  :defer t
  :config
  ;; Flycheck
  (add-hook 'puppet-mode-hook 'flycheck-mode-on-safe)

  ;; Indent without tabs
  (add-hook 'puppet-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)))
  (rs/add-common-programming-hooks 'puppet-mode))


(provide 'rs-lang-puppet)
;;; rs-lang-puppet.el ends here
