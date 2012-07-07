; Project Config
(setq project-roots
      '((python :root-contains-files (".ropeproject"))
        (python :root-contains-files ("setup.py"))))

(defun project-root-compile ()
  "Compile the project, using the project root as the cwd."
  (interactive)
  (with-project-root (compile)))
