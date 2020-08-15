
(setq sql-presets-file "~/.sqlpresets.el")

(when (file-exists-p sql-presets-file)
  (load sql-presets-file))
