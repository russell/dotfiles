;;; rs-ivy.el --- Ivy                              -*- lexical-binding: t; -*-

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

(prelude-require-packages '(ivy-rich all-the-icons-ivy-rich))

(use-package ivy-rich
  :ensure t
  :after (ivy)
  :config (ivy-rich-mode 1))

(use-package all-the-icons-ivy-rich
  :ensure t
  :after (ivy-rich)
  :init (all-the-icons-ivy-rich-mode 1))

(use-package counsel
  :config
  (setq counsel-describe-function-function #'helpful-callable
        counsel-describe-variable-function #'helpful-variable))

(provide 'rs-ivy)
;;; rs-ivy.el ends here
