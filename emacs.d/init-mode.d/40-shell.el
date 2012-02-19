;; Terminal color config
(setq ansi-color-names-vector ["black" "tomato" "#8ae234" "#edd400"
			       "#729fcf" "#ad7fa8" "light cyan" "white"])
(setf ansi-color-map (ansi-color-make-color-map))
(setq ansi-term-color-vector [unspecified "black" "tomato" "#8ae234" "#edd400"
					  "#729fcf" "#ad7fa8" "light cyan" "white"])

(setq term-default-bg-color "#2e3434")
(setq term-default-fg-color "#eeeeec")

;; Shell
(defun add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification
	       '(:propertize (" " default-directory " ") face dired-directory)))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)

;; Term
(add-hook 'term-mode-hook (lambda ()
                            (define-key term-raw-map (kbd "C-y") 'term-paste)))
(add-hook 'term-mode-hook 'add-mode-line-dirtrack)
