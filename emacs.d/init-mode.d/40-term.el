;;; -*- lexical-binding: t -*-

(require 'term)

(setq term-term-name "Eterm-color")

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
                     (file-name-nondirectory
                      (directory-file-name
                       (vc-call-backend (vc-deduce-backend) 'root default-directory))))
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

(global-set-key "\C-cd" 'my-ansi-term)
