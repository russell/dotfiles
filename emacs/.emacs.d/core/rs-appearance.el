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

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(prelude-require-packages '(modus-vivendi-theme modus-operandi-theme))

(rs-require-package '(circadian :fetcher github
                                :branch "support-lists-of-themes"
                                :repo "russell/circadian"))

(setq default-frame-alist
      (append (list
	       '(min-height . 1)
               '(height     . 45)
	       '(min-width  . 1)
               '(width      . 81)
               '(vertical-scroll-bars . nil)
               '(internal-border-width . 17)
               '(left-fringe    . 4)
               '(right-fringe   . 4)
               '(tool-bar-lines . 0)
               '(menu-bar-lines . 0))))

(use-package frame
  :custom
  (window-divider-default-right-width 17)
  (window-divider-default-bottom-width 2)
  (window-divider-default-places 'right-only)
  (window-divider-mode t))

(setq x-underline-at-descent-line t)

(use-package circadian
  :ensure t
  :init
  (setq calendar-latitude 49.0)
  (setq calendar-longitude 8.5)
  (setq circadian-themes '((:sunrise . (modus-operandi rs-light))
                           (:sunset  . (modus-vivendi rs-dark))))
  :config
  (circadian-setup))

(provide 'rs-appearance)

;;; rs-appearance.el ends here
