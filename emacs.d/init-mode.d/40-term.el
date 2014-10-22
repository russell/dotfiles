;;; -*- lexical-binding: t -*-

(require 'term)

(defun rs/project-name ()
  (file-name-nondirectory
   (directory-file-name
    (vc-call-backend (vc-deduce-backend) 'root default-directory))))

(defvar term-ansi-at-prog nil)

(defun rs/term-init ()
  ;; Set the ange-ftp variables because there are no default values.
  (setq term-ansi-at-host (system-name))
  (setq term-ansi-at-dir (file-remote-p default-directory 'localname))
  (setq term-ansi-at-message nil)
  (set (make-local-variable 'term-ansi-at-prog) nil)
  (setq ange-ftp-default-user nil)
  (setq ange-ftp-default-password nil)
  (setq ange-ftp-generate-anonymous-password nil))

(add-hook 'term-mode-hook 'rs/term-init)

(defun term-handle-ansi-terminal-messages (message)
  ;; Is there a command here?
  (while (string-match "\eAnSiT.+\n" message)
    ;; Extract the command code and the argument.
    (let* ((start (match-beginning 0))
           (command-code (aref message (+ start 6)))
           (argument
            (save-match-data
              (substring message
                         (+ start 8)
                         (string-match "\r?\n" message
                                       (+ start 8)))))
           ignore)
      ;; Delete this command from MESSAGE.
      (setq message (replace-match "" t t message))

      ;; If we recognize the type of command, set the appropriate variable.
      (cond ((= command-code ?c)
             (setq term-ansi-at-dir argument))
            ((= command-code ?h)
             (setq term-ansi-at-host argument))
            ((= command-code ?u)
             (setq term-ansi-at-user argument))
            ((= command-code ?p)
             (setq term-ansi-at-prog argument))
            ;; Otherwise ignore this one.
            (t
             (setq ignore t)))

      ;; Update default-directory based on the changes this command made.
      (if ignore
          nil

        (setq default-directory
              (file-name-as-directory
               (if (and (string= term-ansi-at-host (system-name))
                        (string= term-ansi-at-user (user-real-login-name)))
                   (expand-file-name (or term-ansi-at-dir default-directory))
                 (if (file-remote-p default-directory)
                       (with-parsed-tramp-file-name default-directory nil
                         (tramp-make-tramp-file-name
                          method
                          term-ansi-at-user
                          term-ansi-at-host
                          term-ansi-at-dir))
                     (tramp-make-tramp-file-name
                      nil
                      (unless (string= term-ansi-at-user (user-real-login-name))
                        term-ansi-at-user)
                      term-ansi-at-host
                      term-ansi-at-dir)))))

        ;; I'm not sure this is necessary,
        ;; but it's best to be on the safe side.
        (if (string= term-ansi-at-host (system-name))
            (progn
              (setq ange-ftp-default-user term-ansi-at-save-user)
              (setq ange-ftp-default-password term-ansi-at-save-pwd)
              (setq ange-ftp-generate-anonymous-password term-ansi-at-save-anon))
          (setq term-ansi-at-save-user ange-ftp-default-user)
          (setq term-ansi-at-save-pwd ange-ftp-default-password)
          (setq term-ansi-at-save-anon ange-ftp-generate-anonymous-password)
          (setq ange-ftp-default-user nil)
          (setq ange-ftp-default-password nil)
          (setq ange-ftp-generate-anonymous-password nil)))))
  message)


(defvar term-ansi-ignored-progs '("bash" "zsh"))


(defadvice term-handle-ansi-terminal-messages
  (after rs/update-term-buffer-name (message))
  (cond
   ((and term-ansi-at-prog term-ansi-at-user term-ansi-at-host
         (not (member term-ansi-at-prog term-ansi-ignored-progs)))
    (rename-buffer
     (format "*%s%s@%s*"
               (if term-ansi-at-prog
                    (concat term-ansi-at-prog ":")
                 "")
               term-ansi-at-user
               term-ansi-at-host)
     t))

   ((and term-ansi-at-user term-ansi-at-host)
     (rename-buffer
     (format "*%s@%s*"
               term-ansi-at-user
               term-ansi-at-host) t))))

(ad-activate 'term-handle-ansi-terminal-messages)

(defadvice term-handle-exit
  (after rs/term-kill-buffer-on-exit activate)
  "Kill term buffers on exiting term (C-d or `exit`)."
  (kill-buffer))

(defun yas-dont-activate ()
  (yas-minor-mode -1))

(add-hook 'term-mode-hook 'yas-dont-activate)

(defun rs/ansi-term (&optional default-location-p new-buffer-name)
  (interactive "P")
  (let* ((default-directory (if default-location-p
                                (expand-file-name "~/")
                              default-directory))
         (program
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

    (switch-to-buffer term-ansi-buffer-name)
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))

(global-set-key "\C-cc" 'rs/ansi-term)
