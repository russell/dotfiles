;;; rs-lsp.el --- LSP                                -*- lexical-binding: t; -*-

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

(defun rs-lsp-mode-hook()
  ;; `read-process-output-max' is only available on recent development
  ;; builds of Emacs 27 and above.
  (setq-local read-process-output-max (* 1024 1024))
  ;; REVIEW LSP causes a lot of allocations, with or without Emacs 27+'s
  ;;        native JSON library, so we up the GC threshold to stave off
  ;;        GC-induced slowdowns/freezes. Doom uses `gcmh' to enforce its GC
  ;;        strategy, so we modify its variables rather than
  ;;        `gc-cons-threshold' directly.
  (setq-local gcmh-high-cons-threshold (* 2 (default-value 'gcmh-high-cons-threshold))))

(use-package lsp-mode
  :config
  (add-hook 'lsp-mode-hook 'rs-lsp-mode-hook))

(provide 'rs-lsp)
;;; rs-lsp.el ends here
