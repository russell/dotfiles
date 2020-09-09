;;; funcs.el --- rs-org layer packages file for Spacemacs.
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
(defun rs/goto-current-journal()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))



(defun rs/getcal (url diary-filename &optional non-marking)
  "Download ics file and add it to file"
  (with-current-buffer (find-file-noselect (url-file-local-copy url))
    (unwind-protect
        (progn
          (when (find-buffer-visiting diary-filename)
            (kill-buffer (find-buffer-visiting diary-filename)))
          (delete-file diary-filename)
          (save-current-buffer (icalendar-import-buffer diary-filename t non-marking)))
      (delete-file (buffer-file-name)))))

(defun rs/getcals ()
  "Load a set of ICS calendars into Emacs diary files"
  (interactive)
  (with-current-buffer (find-file-noselect diary-file)
    (mapcar #'(lambda (x)
                (let* ((filename (format "diary.%s" (car x)))
                       (file (format "%s%s" (file-name-directory diary-file) filename))
                       (url (cdr x)))
                  (message "%s" (concat "Loading " url " into " file))
                  (rs/getcal url file)
                  (let ((include-line (format "#include \"%s\"" filename)))
                    (unless (save-excursion
                              (goto-char (point-min))
                              (search-forward include-line nil t))
                      (goto-char (point-min))
                      (insert (concat include-line "\n"))))
                  ))
            rs/calendars)
    (save-buffer)
    (when (find-buffer-visiting diary-file)
      (kill-buffer (find-buffer-visiting diary-file)))))
