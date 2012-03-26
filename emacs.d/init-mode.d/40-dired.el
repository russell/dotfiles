;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)

(setq-default dired-omit-files-p t) ; this is buffer-local variable

(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
