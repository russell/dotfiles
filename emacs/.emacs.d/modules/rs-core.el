;;; rs-core.el --- Core                              -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Russell Sim

;; Author: Russell Sim <russell@mowgli>
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

(setq confirm-kill-emacs 'yes-or-no-p)
(put 'set-goal-column 'disabled nil)
(setq history-delete-duplicates t)

;; Disable creating .#file lockiles
(setq create-lockfiles nil)

(setq vc-follow-symlinks t)

(setq helm-ag-use-temp-buffer t)
(setq helm-follow-mode-persistent nil)
(setq helm-show-completion-display-function 'helm-show-completion-default-display-function)
(setq helm-mode-handle-completion-in-region nil)

(setq helm-show-completion-display-function 'helm-show-completion-default-display-function)
(setq helm-mode-handle-completion-in-region nil)


(prelude-require-packages '(helm-swoop))

(provide 'rs-core)
;;; rs-core.el ends here
