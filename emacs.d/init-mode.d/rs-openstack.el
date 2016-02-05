
;;; Code:

(require 'use-package)

(use-package openstack-mode
  :defer t
  :config
  (setq openstack-auth-url "http://keystone.rc.nectar.org.au:5000/v2.0")
  (load "~/.openstack"))


(provide 'rs-openstack)
;;; rs-openstack.el ends here
