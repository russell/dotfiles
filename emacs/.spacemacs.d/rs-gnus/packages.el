;;; packages.el --- rs-gnus layer packages file for Spacemacs.
;;
;; Copyright (c) 2020 Russell Sim
;;
;; Author: Russell Sim <russell.sim@github.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst rs-gnus-packages
  '(
    gnus
    ))

(defun rs-gnus/init-gnus ()
  (use-package gnus)
  (use-package gnus-cloud
    :config
    (progn

      (defcustom gnus-cloud-epg-encrypt-to nil
        "Recipient(s) used for encrypting files.
May either be a string or a list of strings."
        :group 'gnus-cloud
        :type '(list string))

      (defun gnus-cloud-encode-data ()
        (cond
         ((eq gnus-cloud-storage-method 'base64-gzip)
          (progn
            (call-process-region (point-min) (point-max) "gzip"
                                 t (current-buffer) nil
                                 "-c")
            (base64-encode-region (point-min) (point-max))))

         ((eq gnus-cloud-storage-method 'base64)
          (base64-encode-region (point-min) (point-max)))

         ((eq gnus-cloud-storage-method 'epg)
          (let ((context (epg-make-context 'OpenPGP))
                (recipients
                 (cond
                  ((listp gnus-cloud-epg-encrypt-to) gnus-cloud-epg-encrypt-to)
                  ((stringp gnus-cloud-epg-encrypt-to) (list gnus-cloud-epg-encrypt-to))))
                cipher)
            (setf (epg-context-armor context) t)
            (setf (epg-context-textmode context) t)
            (let ((data (epg-encrypt-string context
                                            (buffer-substring-no-properties
                                             (point-min)
                                             (point-max))
                                            (epg-list-keys context recipients t))))
              (delete-region (point-min) (point-max))
              (insert data))))

         ((null gnus-cloud-storage-method)
          (gnus-message 5 "Leaving cloud data plaintext"))
         (t (gnus-error 1 "Invalid cloud storage method %S"
                        gnus-cloud-storage-method)))))
    )
  )


;;; packages.el ends here
