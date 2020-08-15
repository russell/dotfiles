
;;; Code:

(eval-when-compile
  (require 'use-package))

; PO Mode


(use-package po-mode
  :defer t
  :config
  (setq po-auto-replace-file-header nil)
  (setq po-auto-replace-revision-date nil)
  (setq po-default-file-header "\
msgid \"\"
msgstr \"\"
\"MIME-Version: 1.0\\n\"
\"Content-Type: text/plain; charset=UTF-8\\n\"
\"Content-Transfer-Encoding: 8bit\\n\"
"))


(provide 'rs-lang-po)
;;; rs-lang-po.el ends here
