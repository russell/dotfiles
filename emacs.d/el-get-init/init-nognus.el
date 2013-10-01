
(defadvice gnus (around gnus-around)
  "Force start in home directory."
  (let ((default-directory (expand-file-name "~")))
    ad-do-it))

(ad-activate 'gnus)
