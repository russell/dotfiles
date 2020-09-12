;;; rs-packages.el --- Package                       -*- lexical-binding: t; -*-

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

(prelude-require-package 'quelpa)
(require 'quelpa)

(defvar rs-packages nil)

(defun rs-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq (car package) rs-packages)
    (add-to-list 'rs-packages (car package)))
  (unless (package-installed-p (car package))
    (funcall #'quelpa package)))


(provide 'rs-packages)
;;; rs-packages.el ends here
