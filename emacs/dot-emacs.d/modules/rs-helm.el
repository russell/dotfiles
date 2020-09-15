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
(use-package helm-elisp
  :config
  (progn
    (setq helm-show-completion-display-function 'helm-show-completion-default-display-function)))

(use-package helm-mode
  :config
  (progn
    (setq helm-mode-handle-completion-in-region nil)))

(use-package helm-grep
  :config
  (progn
    (setq helm-grep-ag-command
          (concat "rg"
                  " --no-config"
                  ;; " --hidden"
                  " --color=always"
                  " --colors 'match:fg:yellow'"
                  " --colors 'match:style:nobold'"
                  " --no-heading -S -n %s %s %s")
          helm-grep-file-path-style 'relative)))

(use-package helm-swoop
  :bind (("C-S-s" . helm-swoop))
  :config
  (progn
    (defadvice helm-swoop (around helm-swoop-around)
      "Mark if the function changes the point."
      (xref-push-marker-stack)
      ad-do-it)

    (ad-activate 'helm-swoop)))

(provide 'rs-helm)
;;; rs-helm.el ends here
