(gnus-calendar-setup)

;; to enable optional iCalendar->Org sync functionality
;; NOTE: both the capture file and the headline(s) inside must already exist
(setq gnus-calendar-org-capture-file "~/org/agenda.org")
(setq gnus-calendar-org-capture-headline '("Calendar"))
(gnus-calendar-org-setup)
