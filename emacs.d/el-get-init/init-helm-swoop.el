;; Locate the helm-swoop folder to your path
(require 'helm-swoop)


(defadvice helm-swoop (around helm-swoop-around)
  "Mark if the function changes the point."
  (let ((current-point (point)))
    ad-do-it
    (push-mark current-point)))

(ad-activate 'helm-swoop)


(global-set-key (kbd "C-x g") 'helm-swoop)
;; (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
