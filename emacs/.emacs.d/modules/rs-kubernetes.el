;;; rs-kubernetes.el --- Kubernetes Helpers          -*- lexical-binding: t; -*-

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

(require 'consult)

(defvar rs//kubectl-ctx-history nil)

(defun rs/consult--kubectl-ctx (prompt)
  "List all Kubernetes contexts.
PROMPT is the text show at the minibuffer."
  (consult--read
   (consult--async-command "kubectl config get-contexts -o name")
   :prompt prompt
   :sort nil
   :require-match t
   :initial (string-trim
             (shell-command-to-string "kubectl config current-context"))
   :category 'kubernetes-context
   :history '(:input rs//kubectl-ctx-history)))

;;;###autoload
(defun rs/consult-kubectl-ctx ()
  "Switch Kubernetes contexts."
  (interactive)
  (let ((new-context (rs/consult--kubectl-ctx "Context: ")))
    (shell-command (format "kubectl config use-context %s" new-context))
    (message "Set Kubernetes context: %s" new-context)))

(defun eshell/kubectx ()
  "Kubernetes context switcher."
  (rs/consult-kubectl-ctx))

(provide 'rs-kubernetes)
;;; rs-kubernetes.el ends here
