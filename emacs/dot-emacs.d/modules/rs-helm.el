;;; rs-helm.el --- Helm                              -*- lexical-binding: t; -*-

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

(prelude-require-packages '(helm-swoop helm-rg))

;; (setq helm-follow-mode-persistent nil)
(setq helm-show-completion-display-function 'helm-show-completion-default-display-function)
(setq helm-mode-handle-completion-in-region nil)

(setq helm-show-completion-display-function 'helm-show-completion-default-display-function)
(setq helm-mode-handle-completion-in-region nil)

(use-package helm-swoop
  :bind (("C-S-s" . helm-swoop)))

(provide 'rs-helm)
;;; rs-helm.el ends here
