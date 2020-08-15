
;;; Code:

(eval-when-compile
  (require 'use-package))


(use-package helm-swoop
  :bind
  ("C-x g" . helm-swoop)

  :config

  (defadvice helm-swoop (around helm-swoop-around)
  "Mark if the function changes the point."
  (let ((current-point (point)))
    ad-do-it
    (push-mark current-point)))

  (ad-activate 'helm-swoop))

(provide 'init-helm-swoop)
;;; init-helm-swoop.el ends here
