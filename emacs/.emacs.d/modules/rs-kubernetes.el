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
(defvar rs//kubectl-ctx-namespace nil)

(defun rs/consult--kubectl-ctx (prompt)
  "List all Kubernetes contexts.
PROMPT is the text show at the minibuffer."
  (consult--read
   (split-string
    (shell-command-to-string "kubectl config get-contexts -o name"))
   :prompt prompt
   :sort t
   :require-match t
   :history '(:input rs//kubectl-ctx-history)))

;;;###autoload
(defun rs/consult-kubectl-ctx ()
  "Switch Kubernetes contexts."
  (interactive)
  (let ((new-context (rs/consult--kubectl-ctx
                      (format "Context '%s': "
                              (string-trim
                               (shell-command-to-string "kubectl config current-context"))))))
    (shell-command (format "kubectl config use-context %s" new-context))
    (message "Set Kubernetes context: %s" new-context)))

(defun eshell/kubectx ()
  "Kubernetes context switcher."
  (rs/consult-kubectl-ctx))


(defun rs/consult--kubectl-namespace-format (lines)
  "Format kubectl namespace candidates from LINES."
  (let ((candidates))
    (dolist (str lines)
      (push (cadr (split-string str "/")) candidates))
    (nreverse candidates)))

(defun rs/consult--kubectl-namespace (prompt)
  "List all Kubernetes contexts.
PROMPT is the text show at the minibuffer."
  (consult--read
   (rs/consult--kubectl-namespace-format
    (split-string
     (shell-command-to-string "kubectl get namespaces -o=name")))
   :prompt prompt
   :sort t
   :require-match t
   :history '(:input rs//kubectl-namespace-history)))

;;;###autoload
(defun rs/consult-kubectl-namespace ()
  "Switch Kubernetes contexts."
  (interactive)
  (let ((new-context (rs/consult--kubectl-namespace
                      (format "Namespace '%s': "
                              (string-trim
                               (shell-command-to-string "kubectl config view --minify --output 'jsonpath={..namespace}'"))))))
    (shell-command (format "kubectl config set-context --current --namespace=%s" new-context))
    (message "Set Kubernetes namespace: %s" new-context)))

(defun eshell/kubens ()
  "Kubernetes context switcher."
  (rs/consult-kubectl-namespace))

(provide 'rs-kubernetes)
;;; rs-kubernetes.el ends here
