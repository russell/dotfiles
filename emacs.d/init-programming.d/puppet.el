(setq puppet-mode-hook nil)

(defun puppet-block-align ()
  "align the => characters for a block"
  (interactive)
  (save-excursion
    (let ((apoint (search-backward "{" nil t))
          (epoint (search-forward "}" nil t)))
      (when apoint
        (align-regexp apoint epoint "\\(\\s-*\\)=>" 1 1)))))

(add-hook 'puppet-mode-hook
          (lambda ()
            (define-key puppet-mode-map "\C-xr" 'puppet-block-align)))

;; Puppet Flymake
(add-hook 'puppet-mode-hook
          (lambda ()
            (flymake-puppet-load)
            (flymake-start-syntax-check)))

;; Indent with tabs
(add-hook 'puppet-mode-hook
          (lambda ()
            (make-local-variable 'indent-tabs-mode)
            (setq indent-tabs-mode t)))

;; Trim whitespace
(add-hook 'puppet-mode-hook
          (lambda ()
            (add-hook 'write-contents-functions
                      '(lambda()
                         (save-excursion
                           (delete-trailing-whitespace))))))
