
;;; Code:

(require 'use-package)

(use-package auto-capitalize
  :config
  (setq auto-capitalize-words '("I" "HTTP" "TCP" "I'm" "C" "Python" "SBCL"
                                "API" "Openstack" "NeCTAR" "RDSI" "Monash")))

(provide 'rs-auto-capaitalize-mode)
;;; rs-auto-capitalize-mode.el ends here
