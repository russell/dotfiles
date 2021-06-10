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

(set-face-attribute 'default nil :family "Iosevka Fixed SS11" :height (if (equal (system-name) "14985-rsim")
                                                                          140
                                                                          130))
(set-face-attribute 'fixed-pitch nil :family "Iosevka Fixed SS11")
(set-face-attribute 'variable-pitch nil :family "CMU Serif" :height 150)

;; enable emoji fonts on  all platforms
(set-fontset-font t 'symbol "Apple Color Emoji")
(set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)

(prelude-require-packages '(circadian modus-vivendi-theme modus-operandi-theme doom-modeline treemacs))
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(use-package circadian
  :ensure t
  :init
  (setq calendar-latitude 49.0)
  (setq calendar-longitude 8.5)
  (setq circadian-themes '((:sunrise . modus-operandi)
                           (:sunset  . modus-vivendi)))
  :config
  (add-to-list 'circadian-after-load-theme-hook 'treemacs-icons-dired-mode)
  (circadian-setup))

(use-package doom-modeline
  :ensure t
  :init
  (progn
    (setq-default doom-modeline-height 28))
  :config (doom-modeline-mode 1))

(use-package treemacs-icons-dired
  :after dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(provide 'rs-appearance)

;;; rs-appearance.el ends here
