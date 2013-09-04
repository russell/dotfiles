(global-set-key "\M-y" 'helm-show-kill-ring)

;; Jump to a definition in the current file. (This is awesome)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "M-x") ')

(require 'helm-match-plugin)

(define-minor-mode ido-helm-mode
  "Advices for ido-mode."
  nil nil nil :global t
  (if ido-helm-mode
      (progn
        (ad-enable-regexp "^ido-hacks-")
        (global-set-key (kbd "M-x") 'helm-M-x))
    (global-set-key (kbd "M-x") 'execute-extended-command)
    (ad-disable-regexp "^ido-hacks-"))
  (ad-activate-regexp "^ido-hacks-"))
