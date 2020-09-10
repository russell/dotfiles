;;; init.el --- Entry point                          -*- lexical-binding: t; -*-

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

(defvar rs-dir (file-name-directory load-file-name))
(defvar rs-modules-dir (expand-file-name  "modules" rs-dir) "")
(defvar rs-core-dir (expand-file-name  "core" rs-dir) "")
(defvar rs-modules (expand-file-name  "modules.el" rs-dir) "")

(add-to-list 'load-path rs-core-dir)
(add-to-list 'load-path rs-modules-dir)

(prelude-require-package 'use-package)
(prelude-require-package 'no-littering)

(use-package no-littering
  :init
  (setq no-littering-etc-directory "~/.emacs.d/etc/")
  (setq no-littering-var-directory "~/.emacs-var/")
  :config
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  )

(require 'rs-packages)

(load rs-modules)

(load-file "~/.emacs-private.el")

;;; init.el ends here
