
(eval-when-compile
  (require 'use-package))

;;; Code:

(use-package counsel
  :bind
  ("C-h f" . counsel-describe-function)
  ("C-h v" . counsel-describe-variable))


(use-package ivy
  :init
  (ivy-mode 1)
  :config
  (define-key ivy-minibuffer-map (kbd "C-w") 'ivy-backward-kill-word)
  (define-key ivy-minibuffer-map (kbd "C-l") 'ivy-partial-or-done))

(provide 'init-swiper)
;;; init-swiper.el ends here
