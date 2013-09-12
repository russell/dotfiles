
;; helm kill ring
(global-set-key "\M-y" 'helm-show-kill-ring)

;; helm buffer list
(global-set-key (kbd "C-x b") 'helm-buffers-list)

;; Jump to a definition in the current file. (This is awesome)
(global-set-key (kbd "C-x C-i") 'helm-imenu)

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

(ido-helm-mode)

(custom-set-variables
 '(helm-boring-buffer-regexp-list
   (quote
    ("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*tramp" "\\*Minibuf" "\\*epc"))))

(eval-after-load 'helm-apt
  '(progn
     (require 'apt-utils)
     (defalias 'helm-apt-cache-show
       (lambda (package)
         (apt-utils-show-package-1 package t nil)))))

(defun helm-truncate-lines ()
  (with-current-buffer (get-buffer-create helm-buffer)
    (toggle-truncate-lines t)))

(add-hook 'helm-after-initialize-hook 'helm-truncate-lines)
