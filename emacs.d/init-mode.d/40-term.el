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


(defun my-ansi-term (program &optional new-buffer-name)
  (interactive (let ((default-prog (or explicit-shell-file-name
                                       (getenv "ESHELL")
                                       shell-file-name
                                       (getenv "SHELL")
                                       "/bin/sh")))
                 (list (if (or (null default-prog)
                               current-prefix-arg)
                           (read-from-minibuffer "Run program: " default-prog)
                         default-prog))))
  (let ((project
         (if vc-mode
             (concat ": "
                     (my-project-name))
           "")))

    ;; Pick the name of the new buffer.
    (setq term-ansi-buffer-name
          (if new-buffer-name
              new-buffer-name
            (if term-ansi-buffer-base-name
                (if (eq term-ansi-buffer-base-name t)
                    (file-name-nondirectory program)
                  term-ansi-buffer-base-name)
              (concat "ansi-term" project)))))

  (setq term-ansi-buffer-name (concat "*" term-ansi-buffer-name "*"))
  (if (get-buffer term-ansi-buffer-name)
      (switch-to-buffer term-ansi-buffer-name)
    (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))

    (setq term-ansi-buffer-name (term-ansi-make-term term-ansi-buffer-name program))

    (set-buffer term-ansi-buffer-name)
    (term-mode)
    (term-char-mode)
    (let (term-escape-char)
      ;; I wanna have find-file on C-x C-f -mm
      ;; your mileage may definitely vary, maybe it's better to put this in your
      ;; .emacs ...
      (term-set-escape-char ?\C-x))

    (switch-to-buffer term-ansi-buffer-name)))

(global-set-key "\C-cc" 'my-ansi-term)
