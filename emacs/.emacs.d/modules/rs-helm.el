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

(prelude-require-packages '(helm-swoop helm-rg helm-notmuch))

(use-package helm
  :config
  (setq helm-reuse-last-window-split-state        t
        helm-always-two-windows                   t
        helm-split-window-inside-p                nil
        helm-commands-using-frame                 nil
        helm-actions-inherit-frame-settings       t
        helm-use-frame-when-more-than-two-windows nil
        helm-use-frame-when-dedicated-window      nil
        helm-show-action-window-other-window      'left
        helm-allow-mouse                          t
        helm-autoresize-max-height                80 ; it is %.
        helm-autoresize-min-height                20 ; it is %.
        helm-display-buffer-height                30
        helm-display-buffer-width                 110
        ))

;; (setq helm-follow-mode-persistent nil)
(use-package helm-elisp
  :config
  (progn
    (setq helm-show-completion-display-function 'helm-show-completion-default-display-function)))

(use-package helm-buffers
  :config
  (setq helm-buffers-fuzzy-matching       t
        helm-buffer-skip-remote-checking  t
        helm-buffer-max-length            22
        helm-buffers-end-truncated-string "…"))

(use-package helm-adaptive
  :config
  (helm-adaptive-mode 1))

(use-package helm-files
  :config
  (setq helm-ff-auto-update-initial-value        t
        helm-ff-allow-non-existing-file-at-point t
        helm-ff-cache-mode-post-delay            0.3
        helm-ff-refresh-cache-delay              0.3))

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
                  " --color=always"
                  " --colors 'match:fg:yellow'"
                  " --colors 'match:style:nobold'"
                  " --no-heading"
                  " -S -n %s %s %s")
          helm-grep-ag-pipe-cmd-switches
          '("--colors 'match:bg:yellow' --colors 'match:fg:black'")
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

(use-package helm-locate
  :config
  (setq helm-locate-fuzzy-match t))

(use-package helm-notmuch
  :bind (:map rs-applications-map
              ("N" . helm-notmuch)))

(provide 'rs-helm)
;;; rs-helm.el ends here
