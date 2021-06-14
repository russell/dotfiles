;;; rs-global-mode.el --- A mode for handling Global keybinds  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Russell Sim

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

(defvar rs-global-mode-map
  (let ((map (make-sparse-keymap)))
    ;; extra prefix for projectile
    (define-key map (kbd "C-c p") 'projectile-command-map)
    map)
  "Keymap for rs-global mode.")


;; define minor mode
(define-minor-mode rs-global-mode
  "Minor mode to consolidate Emacs Rs-Global extensions.

\\{rs-global-mode-map}"
  :lighter " RS-GL"
  :keymap rs-global-mode-map)

(defcustom rs-mode-disabled-major-modes '()
  "List of major modes that should not use `rs-global-mode'."
  :type 'sexp)

(defun rs-global-mode-on ()
  (unless (member major-mode rs-mode-disabled-major-modes)
    (rs-global-mode)))

;;;###autoload
(define-globalized-minor-mode global-rs-global-mode
  rs-global-mode
  rs-global-mode-on)

(global-rs-global-mode)

(provide 'rs-global-mode)
;;; rs-global-mode.el ends here
