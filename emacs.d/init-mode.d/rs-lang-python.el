

;;; Code:

(eval-when-compile
  (require 'use-package)
  (require 'noflet))


(use-package python
  :defer t
  :config
  ;; Smartparens
  (add-hook 'python-mode-hook 'smartparens-strict-mode)

  ;; Flycheck
  (add-hook 'python-mode-hook 'flycheck-mode-on-safe)

  (defadvice python-indent-dedent-line-backspace (around python-indent-dedent-line-backspace-around)
    "Replace the backward-delete-char function with the smartparens
one."
    (noflet ((backward-delete-char-untabify (arg &optional killp)
                                            (sp-backward-delete-char arg)))
    ad-do-it))

  (ad-activate 'python-indent-dedent-line-backspace)


  ;; highlight indentation and symbols
  (add-hook 'python-mode-hook 'highlight-indentation-mode)


  (defvar rs/python-source-setup-code
    "def source(filename):
    import os
    import subprocess

    command = ['bash', '-c', 'source %s && env' % filename]

    proc = subprocess.Popen(command, stdout = subprocess.PIPE)

    for line in proc.stdout:
        (key, _, value) = line.partition(\"=\")
        os.environ[key] = value[:-1]  # strip newline

    proc.communicate()
")

  (add-to-list 'python-shell-setup-codes 'rs/python-source-setup-code))


(defun rs/copy-break-point ()
  (interactive)
  (kill-new (concat (or (file-remote-p (buffer-file-name) 'localname)
                        (buffer-file-name))
                    ":"
                    (number-to-string (line-number-at-pos)))))

(provide 'rs-lang-python)
;;; rs-lang-python.el ends here
