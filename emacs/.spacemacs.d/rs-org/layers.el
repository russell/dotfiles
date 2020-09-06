;;; layers.el --- rs-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2020 Russell Sim
;;
;; Author: Russell Sim <russell.sim@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(configuration-layer/declare-layer 'deft)
(configuration-layer/declare-layer '(org :variables
                                         org-enable-jira-support t
                                         org-enable-hugo-support t
                                         org-enable-org-journal-support t))
