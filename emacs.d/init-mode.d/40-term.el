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

(defun yas-dont-activate ()
  (yas-minor-mode -1))

(add-hook 'term-mode-hook 'yas-dont-activate)

(defun my-ansi-term (&optional new-buffer-name)
  (interactive)
  (let* ((program
          (if (file-remote-p default-directory)
              "/usr/bin/ssh"
            "/usr/bin/zsh"))
         (switches (when (file-remote-p default-directory 'host)
                     (list (file-remote-p default-directory 'host)
                           "-t"
                           (format "cd %s; /bin/bash --login"
                                   (file-remote-p default-directory 'localname))))))

    ;; Pick the name of the new buffer.
    (setq term-ansi-buffer-name
          (if new-buffer-name
              new-buffer-name
            (if term-ansi-buffer-base-name
                (if (eq term-ansi-buffer-base-name t)
                    (file-name-nondirectory program)
                  term-ansi-buffer-base-name)
              "ansi-term")))

    (setq term-ansi-buffer-name (concat "*" term-ansi-buffer-name "*"))

    (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))
    (setq term-ansi-buffer-name (apply 'term-ansi-make-term term-ansi-buffer-name program nil switches))

    (set-buffer term-ansi-buffer-name)
    (term-mode)
    (term-char-mode)
    (let (term-escape-char)
      (term-set-escape-char ?\C-x))

    (switch-to-buffer term-ansi-buffer-name)))

(defun my-term-init ()
  ;; Set the ange-ftp variables because there are no default values.

  (setq ange-ftp-default-user nil)
  (setq ange-ftp-default-password nil)
  (setq ange-ftp-generate-anonymous-password nil))

(add-hook 'term-mode-hook 'my-term-init)

(global-set-key "\C-cc" 'my-ansi-term)
