
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t)
  (setq projectile-file-exists-remote-cache-expire nil)
  (setq projectile-completion-system 'helm))

(provide 'init-projectile)
;;; init-projectile.el ends here
