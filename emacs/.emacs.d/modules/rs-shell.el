;;; rs-shell.el --- Shell configuration              -*- lexical-binding: t; -*-

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

(prelude-require-packages
 '(bash-completion
   fish-completion
   eshell-prompt-extras
   eshell-z))

(rs-require-package '(project-shells :fetcher github
                                     :repo "russell/project-shells"))

(use-package project-shells
  :config
  (global-project-shells-mode))

(use-package eshell-z
  :after eshell)

(use-package eshell-prompt-extras
  :commands epe-theme-multiline-with-status
  :after em-prompt
  :init
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-multiline-with-status))

(use-package bash-completion
  :after eshell)

(use-package fish-completion
  :after eshell
  :config
  (when (and (executable-find "fish")
             (require 'fish-completion nil t))
    (global-fish-completion-mode)))

(use-package eshell
  :config
  (setq eshell-modules-list
        '(eshell-alias
          eshell-banner
          eshell-basic
          eshell-cmpl
          eshell-dirs
          eshell-glob
          eshell-hist
          eshell-ls
          eshell-pred
          eshell-prompt
          eshell-script
          eshell-smart
          eshell-term
          eshell-tramp
          eshell-unix
          eshell-xtra)))


(use-package em-term
  :config
  (progn
    (setq eshell-destroy-buffer-when-process-dies t
          eshell-visual-subcommands '(("git" "log" "diff" "show")
                                      ("kubectl" "ctx")))))

(defun rs-disable-pcomplete-in-org (orig-fun &rest args)
  (when (not (eq org-src-window-setup 'switch-invisibly))
    (apply orig-fun args)))

(advice-add 'pcomplete-completions-at-point :around #'rs-disable-pcomplete-in-org)

(use-package comint
  :config
  (progn
    (setq comint-input-ignoredups t)))

(provide 'rs-shell)
;;; rs-shell.el ends here
