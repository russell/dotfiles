
;;; Code:

(eval-when-compile
  (require 'use-package))

(require 'rs-lang-common)

;; http://speeves.erikin.com/2011/10/emacs-sql-mode-connect-to-multiple.html

(use-package sql
  :defer t
  :config
  (setq sql-connection-alist
        '((pool-test
           (sql-name "test")
           (sql-product 'postgres)
           (sql-server "localhost")
           (sql-user "test")
           (sql-database "test")
           (sql-port 5432)
           (sql-postgres-options '("-P" "pager=off")))))

  (add-hook 'sql-interactive-mode-hook 'rs/common-repl-modes)
  (add-hook 'sql-interactive-mode-hook
          (lambda ()
            (setq sql-alternate-buffer-name (sql-make-smart-buffer-name))
            (sql-rename-buffer))))


(defun sql-connect-test ()
  (interactive)
  (sql-connect-preset 'pool-test))


;; this makes all it all happen via M-x sql-pool-host1_db1, etc.
(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
           (flet ((sql-get-login (&rest what)))
             (sql-product-interactive sql-product (sql-make-smart-buffer-name))))))

;; names the buffer *SQL: <host>_<db>, which is easier to
;; find when you M-x list-buffers, or C-x C-b
(defun sql-make-smart-buffer-name ()
  "Return a string that can be used to rename a SQLi buffer.
  This is used to set `sql-alternate-buffer-name' within
  `sql-interactive-mode'."
  (or (and (boundp 'sql-name) sql-name)
      (concat (if (not(string= "" sql-server))
                  (concat
                   (or (and (string-match "[0-9.]+" sql-server) sql-server)
                       (car (split-string sql-server "\\.")))
                   "/"))
              sql-database)))

(provide 'rs-lang-sql)
;;; rs-lang-sql.el ends here
