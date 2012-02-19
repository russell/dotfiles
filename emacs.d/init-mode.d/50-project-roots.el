; Project Config
(setq project-roots
      `(("Python rope project"
	 :root-contains-files (".ropeproject")
         )
	("Python project"
         :root-contains-files ("setup.py")
         )))

(defun project-root-compile ()
  "Compile the project, using the project root as the cwd."
  (interactive)
  (with-project-root (compile)))
