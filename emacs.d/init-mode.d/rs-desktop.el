
;;; Code:

(eval-when-compile
  (require 'use-package))


(require 'desktop)

(custom-set-variables
 '(desktop-buffers-not-to-save
   (concat "\\("
           "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
           "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
           "\\)$"))
 '(desktop-files-not-to-save  "^$")
 '(desktop-save t))

(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'Man-mode)
(add-to-list 'desktop-modes-not-to-save 'help-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)

(provide 'rs-desktop)
;;; rs-desktop.el ends here
