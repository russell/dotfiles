
;;; Code:

(eval-when-compile
  (require 'use-package))

(use-package auto-capitalize
  :commands (auto-capitalize-mode
             turn-on-auto-capitalize-mode
             turn-off-auto-capitalize-mode
             enable-auto-capitalize-mode)
  :config
  (setq auto-capitalize-words '("I" "HTTP" "TCP" "I'm" "C" "Python" "SBCL"
                                "API" "Openstack" "NeCTAR" "RDSI" "Monash")))

(provide 'rs-auto-capaitalize-mode)
;;; rs-auto-capitalize-mode.el ends here
