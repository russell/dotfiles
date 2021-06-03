;;; rs-core.el --- Core                              -*- lexical-binding: t; -*-

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

(require 'warnings)

(prelude-require-packages '(envrc winum eyebrowse gcmh popper))

(setq frame-title-format '("" invocation-name " - "
                          (:eval
                           (if
                               (buffer-file-name)
                               (abbreviate-file-name
                                (buffer-file-name))
                             "%b"))))

(setq confirm-kill-emacs 'yes-or-no-p)
(put 'set-goal-column 'disabled nil)
(setq history-delete-duplicates t)

;; Disable creating .#file lockiles
(setq create-lockfiles nil)

(setq vc-follow-symlinks t)

(setq kill-do-not-save-duplicates t)

;; Disable undo-tree, it seems to be responsible for hanging while
;; recording history
(global-undo-tree-mode 0)

(push 'comp warning-suppress-types)
(push 'bytecomp warning-suppress-types)

;; Tab only tabs, doesn't trigger completion.
(setq tab-always-indent t)

(if (string-equal "darwin" (symbol-name system-type))
    (progn
      (setq default-directory (concat (getenv "HOME") "/"))
      (setenv "PATH" (concat "/opt/local/bin:/opt/local/sbin:" (getenv "PATH")))
      (setq epg-gpg-program "/usr/local/bin/gpg2")))

;; Only show some whitespace
(use-package whitespace
  :config
  (setq whitespace-style '(face tabs empty trailing missing-newline-at-eof)))


(use-package avy
  :config
  ;; avy use Dvorak keys for jumping
  (setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s)))

(use-package envrc
  :init
  (envrc-global-mode))

(use-package winum
  :init
  (winum-mode)
  :bind*
  (("M-0" . 'winum-select-window-0-or-10)
   ("M-1" . 'winum-select-window-1)
   ("M-2" . 'winum-select-window-2)
   ("M-3" . 'winum-select-window-3)
   ("M-4" . 'winum-select-window-4)
   ("M-5" . 'winum-select-window-5)
   ("M-6" . 'winum-select-window-6)
   ("M-7" . 'winum-select-window-7)
   ("M-8" . 'winum-select-window-8)
   ("M-9" . 'winum-select-window-9)))

;; disable ace-window
(global-set-key [remap other-window] 'other-window)

(use-package eyebrowse
  :config (eyebrowse-mode))

(use-package gcmh
  :init
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 16 1024 1024)) ; 16mb
  :config
  (gcmh-mode))

(defun rs-popper-select-popup-at-bottom (buffer &optional _alist)
  "Display and switch to popup-buffer BUFFER at the bottom of the screen."
  (let ((window (display-buffer-in-side-window
                 buffer
                 '((window-height . (lambda (win)
                                      (fit-window-to-buffer
                                       win
                                       (floor (frame-height) 3)
                                       (floor (frame-height) 6))))
                   (side . bottom)
                   (slot . 1)))))
    (select-window window)))

(use-package popper
  :ensure t ; or :straight t
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-group-function #'popper-group-by-projectile
        popper-display-function #'rs-popper-select-popup-at-bottom
        popper-reference-buffers '("\\*Messages\\*$"
                                   "\\*Warnings\\*$"
                                   \"Output\\*$\"
                                   help-mode
                                   compilation-mode

                                   ;; Ruby buffers
                                   "^\\*RuboCop "
                                   "^\\*rspec-compilation\\*"

                                   ;; Terminal Modes
                                   eshell-mode
                                   shell-mode
                                   term-mode

                                   ;; Lisp Buffer mode
                                   inferior-emacs-lisp-mode))
  :config
  (popper-mode))

(provide 'rs-core)
;;; rs-core.el ends here
