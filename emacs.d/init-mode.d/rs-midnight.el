
;;; Code:

(require 'use-package)

(use-package midnight
  :config
  (custom-set-variables
   '(clean-buffer-list-delay-special 86400)
   '(clean-buffer-list-kill-never-regexps
     (quote
      ("^\\*tramp/.*\\*$" "^ \\*Minibuf-.*\\*$" "^#.*$" "^\\*\\*df.\\*\\**$"))))

  ;; Cleanup buffers at 4:30am
  (midnight-delay-set 'midnight-delay "4:30am"))

(provide 'rs-midnight)
;;; rs-midnight.el ends here
