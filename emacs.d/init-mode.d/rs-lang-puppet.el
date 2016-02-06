
;;; Code:

(require 'use-package)


(use-package puppet-mode
  :defer t
  :config
  ;; Flycheck
  (add-hook 'puppet-mode-hook 'flycheck-mode-on-safe)

  ;; Indent without tabs
  (add-hook 'puppet-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil))))


(provide 'rs-lang-puppet)
;;; rs-lang-puppet.el ends here
