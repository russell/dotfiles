; Markdown Mode
(defun lconfig-markdown-mode ()
  (progn
    (auto-fill-mode)
    (flyspell-mode)
    ))
(add-hook 'markdown-mode-hook 'lconfig-markdown-mode)
