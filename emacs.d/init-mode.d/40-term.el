;;; -*- lexical-binding: t -*-

(require 'term)

(setq term-term-name "Eterm-color")

(defun my-project-name ()
  (file-name-nondirectory
   (directory-file-name
    (vc-call-backend (vc-deduce-backend) 'root default-directory))))


(defadvice term-handle-ansi-terminal-messages (after update-term-buffer-name (message))
  (when (and term-ansi-at-user term-ansi-at-host)
      (rename-buffer (concat "*" term-ansi-at-user "@" term-ansi-at-host "*") t)))

(ad-activate 'term-handle-ansi-terminal-messages)


(add-hook 'term-exec-hook (lambda ()
            (let* ((buff (current-buffer))
                 (proc (get-buffer-process buff)))
            (lexical-let ((buff buff))
               (set-process-sentinel proc (lambda (process event)
                            (if (string= event "finished\n")
                                       (kill-buffer buff))))))))

(defun my-ansi-term (&optional new-buffer-name)
  (interactive)
  (ansi-term "/usr/bin/zsh" new-buffer-name))

(global-set-key "\C-cc" 'my-ansi-term)
