
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package web-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  :config

  (setq web-mode-engines-alist
        '(("django" . "\\.html\\'")))

  (setq-default web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

  (add-hook 'web-mode-hook 'flyspell-prog-mode)
  (add-hook 'web-mode-hook 'toggle-highlight-symbol)
  (add-hook 'web-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'web-mode-hook
            '(lambda ()
               (add-hook 'write-contents-functions
                         'delete-trailing-whitespace))))

(provide 'init-web-mode)

;;; init-web-mode.el ends here
