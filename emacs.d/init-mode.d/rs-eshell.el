
;;; Code:

(eval-when-compile
  (require 'use-package))

(defun rs/add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification
               '(:propertize (" " default-directory " ") face dired-directory)))

(defun rs/eshell (&optional buffer)
  (interactive)
  (let* ((tramp-path (when (tramp-tramp-file-p default-directory)
                       (tramp-dissect-file-name default-directory)))
         (host (tramp-file-name-real-host tramp-path))
         (user (if (tramp-file-name-user tramp-path)
                 (format "%s@" (tramp-file-name-user tramp-path)) ""))
         (new-buffer-name (format "*eshell:%s%s*" user host)))

    (if host
        (let ((eshell-buffer-name new-buffer-name))
          (eshell))
      (eshell buffer))))

(defvar openstack-rc-directory "~/.os/")

(defun eshell-source-env-file (filename)
  (interactive
   (list (ido-read-file-name "Find Openstackrc: " openstack-rc-directory)))
	 (eshell-do-eval
      (catch 'eshell-replace-command
        (eshell-source-file filename))))

(defun eshell/e (file)
  "Open a file, alias to find-file"
  (find-file file))

(defun eshell/magit (file)
  "Open a magit console."
  (magit-status file))


(defadvice eldoc-current-symbol (around eldoc-current-symbol activate)
  ad-do-it
  (if (and (not ad-return-value)
           (eq major-mode 'eshell-mode))
      (save-excursion
        (goto-char eshell-last-output-end)
        (let ((esym (eshell-find-alias-function (current-word)))
              (sym (intern-soft (current-word))))
          (setq ad-return-value (or esym sum))))))


(use-package eshell
  :bind
  ("<f2>" . rs/eshell)
  :config

  (use-package em-hist
    :config
    (setq eshell-history-size 1000))

  (use-package em-term
    :config
   (setq eshell-term-name "eterm-color"))

  (use-package em-prompt
    :config
    (setq eshell-prompt-function
          (lambda nil
           (concat
            (propertize (concat
                         (or (file-remote-p default-directory 'host) "localhost")
                         ":") 'face '(:foreground "#ff4b4b"))
            (if (= (user-uid) 0) " # " " $ "))))
    (setq eshell-highlight-prompt nil))

  (setq eshell-visual-commands '("vi" "screen" "top" "less" "more" "lynx"
                                 "ncftp" "pine" "tin" "trn" "elm" "aptitude"
                                 "vim" "tig"))

  (setq eshell-modules-list
        '(eshell-alias eshell-basic eshell-cmpl
                       eshell-dirs eshell-glob eshell-hist
                       eshell-ls eshell-pred eshell-prompt
                       eshell-rebind eshell-script eshell-smart
                       eshell-term eshell-unix eshell-xtra))

  (setq eshell-buffer-shorthand t)
  (add-hook 'eshell-mode-hook 'rs/add-mode-line-dirtrack)
  (add-hook 'eshell-mode-hook 'eldoc-mode)
  (rs/add-common-repl-hooks 'eshell-mode)

  ;; a stupid hack, seems that helm is leaking into eshell and this is
  ;; the only way to stop it.
  (add-hook 'eshell-mode-hook
            #'(lambda ()
                (define-key eshell-mode-map [remap pcomplete]
                  'helm-esh-pcomplete))))


(provide 'rs-eshell)
;;; rs-eshell.el ends here
