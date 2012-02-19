;; Compile Current Buffer
(defun compile-current-buffer (&optional comint)
  (interactive (list (consp current-prefix-arg)))
   (setq command (concat (eval compile-command)
	      " " (buffer-file-name)))
  (save-some-buffers (not compilation-ask-about-save) nil)
  (setq-default compilation-directory default-directory)
  (compilation-start command comint))
(global-set-key [f6] 'compile-current-buffer)
