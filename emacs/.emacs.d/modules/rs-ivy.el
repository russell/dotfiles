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

(prelude-require-packages '(counsel-projectile marginalia orderless))

(use-package ivy
  :defer t
  :config
  (setq ivy-re-builders-alist '((t . orderless-ivy-re-builder))))

(use-package orderless
  :ensure t
  :custom (completion-styles '(orderless)))

(use-package marginalia
  :ensure t
  :after (ivy)
  :config
  (marginalia-mode 1))

(use-package all-the-icons-ivy-rich
  :ensure t
  :after (ivy-rich)
  :init (all-the-icons-ivy-rich-mode 1))

(use-package counsel
  :config
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (setq counsel-describe-function-function #'helpful-callable
        counsel-describe-variable-function #'helpful-variable))

(use-package swiper
  :config
  (global-set-key (kbd "C-S-s") 'swiper-thing-at-point))

(use-package counsel-projectile
  :ensure t
  :config (counsel-projectile-mode 1))

(provide 'rs-ivy)
;;; rs-ivy.el ends here
