;;; rs-ruby.el --- Ruby                              -*- lexical-binding: t; -*-

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
 '(rubocop))

(use-package ruby-mode
  :config
  (add-hook 'ruby-mode-hook
            (lambda ()
              (setq-local flycheck-command-wrapper-function
                          (lambda (command) (append `(,(funcall flycheck-executable-find "bundle") "exec") command)))))
  (add-hook 'ruby-mode-hook #'rubocop-mode))

(use-package rubocop
  :config
  (setq
   rubocop-check-command "rubocop --format emacs"
   rubocop-autocorrect-command "rubocop -A --format emacs"
   rubocop-format-command "rubocop -x --format emacs"))

(provide 'rs-ruby)
;;; rs-ruby.el ends here
