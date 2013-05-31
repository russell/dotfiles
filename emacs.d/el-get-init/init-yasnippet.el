
(defun enable-ac-yasnippet ()
  (interactive)
  (when (eq major-mode 'python-mode)
    (setq-local yas/indent-line 'fixed))
  (add-to-list ac-sources 'ac-source-yasnippet))
