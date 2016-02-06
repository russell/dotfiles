
(eval-when-compile
  (require 'use-package))

;;; Code:

(use-package ical-event
  :config
  (setq gnus-calendar-org-capture-file "~/org/agenda.org")
  (setq gnus-calendar-org-capture-headline '("Calendar"))
  (gnus-calendar-setup)
  (gnus-calendar-org-setup))

(provide 'init-ical-event)

;;; init-ical-event.el ends here
