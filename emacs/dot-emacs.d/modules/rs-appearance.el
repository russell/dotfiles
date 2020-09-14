;;; rs-appearance.el --- UI                          -*- lexical-binding: t; -*-

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

(set-face-attribute 'default nil :family "Iosevka Fixed SS11" :height 130)
(set-face-attribute 'fixed-pitch nil :family "Iosevka Fixed SS11")
(set-face-attribute 'variable-pitch nil :family "CMU Serif" :height 150)

(prelude-require-packages '(circadian modus-vivendi-theme modus-operandi-theme doom-modeline treemacs))

;; Disable beacon mode
(beacon-mode 0)

(use-package circadian
  :ensure t
  :config
  (setq calendar-latitude 49.0)
  (setq calendar-longitude 8.5)
  (setq circadian-themes '((:sunrise . modus-operandi)
                           (:sunset  . modus-vivendi)))
  (circadian-setup))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package treemacs-icons-dired
  :after dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(provide 'rs-appearance)

;;; rs-appearance.el ends here
