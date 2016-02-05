
;;; Code:

(require 'use-package)

(use-package savehist
  :init
  (savehist-mode 1)
  :config
  (setq savehist-additional-variables
        '(kill-ring search-ring regexp-search-ring))
  (setq savehist-file "~/.savehist"))

(provide 'rs-savehist)
;;; rs-savehist.el ends here
