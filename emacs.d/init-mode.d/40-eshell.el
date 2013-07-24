;;
;; eshell
;;

(setq eshell-history-size 1000)
(setq eshell-term-name "eterm-color")

(setq eshell-prompt-function
      (lambda nil
        (concat
         (propertize (concat
                      (or (file-remote-p default-directory 'host) "localhost")
                      ":") 'face '(:foreground "#ff4b4b"))
         (if (= (user-uid) 0) " # " " $ "))))

(setq eshell-highlight-prompt nil)

(setq eshell-visual-commands '("vi" "screen" "top" "less" "more" "lynx"
                               "ncftp" "pine" "tin" "trn" "elm" "aptitude" "vim" "tig"))

(setq eshell-modules-list
      '(eshell-alias eshell-basic eshell-cmpl
                     eshell-dirs eshell-glob eshell-hist
                     eshell-ls eshell-pred eshell-prompt
                     eshell-rebind eshell-script eshell-smart
                     eshell-term eshell-unix eshell-xtra))

(setq eshell-buffer-shorthand t)

(defun add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification
               '(:propertize (" " default-directory " ") face dired-directory)))
(add-hook 'eshell-mode-hook 'add-mode-line-dirtrack)

(defun my-eshell (&optional buffer)
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


(global-set-key (kbd "<f2>") 'my-eshell)
