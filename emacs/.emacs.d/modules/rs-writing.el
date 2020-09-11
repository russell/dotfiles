;;; rs-writing.el --- Writing                        -*- lexical-binding: t; -*-

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

(prelude-require-packages '(google-translate markdown-mode writegood-mode))

(use-package google-translate)

(use-package flycheck
  :config
  (progn
    (flycheck-define-checker proselint
      "A linter for prose."
      :command ("proselint" source-inplace)
      :error-patterns
      ((warning line-start (file-name) ":" line ":" column ": "
                (id (one-or-more (not (any " "))))
                (message) line-end))
      :modes (text-mode markdown-mode gfm-mode org-mode org-journal-mode-hook))
    (add-to-list 'flycheck-checkers 'proselint)))

(use-package writegood-mode :defer t)

(use-package text-mode
  :hook
  (text-mode . writegood-mode))

(use-package markdown-mode
  :hook
  ((gfm-mode markdown-mode) . writegood-mode))

(provide 'rs-writing)
;;; rs-writing.el ends here
