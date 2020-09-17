;;; rs-gnus.el --- Gnus                              -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Russell Sim

;; Author: Russell Sim <russell.sim@gmail.com>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(prelude-require-packages '(org-mime))


(use-package gnus
  :bind (:map rs-applications-map
              ("g" . gnus)))

(use-package gnus-cloud
  :config
  (progn
    (eval-when-compile (require 'epg)) ;; setf-method for `epg-context-armor'

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

(provide 'rs-gnus)
;;; rs-gnus.el ends here
