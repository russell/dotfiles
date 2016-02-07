;;; slime-repl.el ---
;;
;; Original Author: Helmut Eller
;; Contributors: to many to mention
;; License: GNU GPL (same license as Emacs)
;;
;;; Description:
;;

;;
;;; Installation:
;;
;; Call slime-setup and include 'slime-repl as argument:
;;
;;  (slime-setup '(slime-repl [others conribs ...]))
;;
(eval-when-compile (require 'slime))

(define-slime-contrib slime-ripple
  "Read-Eval-Print Loop written in Emacs Lisp.

The aim is to provide a shell like function."
  (:authors "too many to mention")
  (:license "GPL")
  (:on-load
   (slime-repl-add-hooks)
   (setq slime-find-buffer-package-function 'slime-repl-find-buffer-package))
  (:on-unload (slime-repl-remove-hooks))
  (:swank-dependencies swank-repl))

;;;;; slime-repl
