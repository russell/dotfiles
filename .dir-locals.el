((nil . ((eval setq helm-grep-ag-command
               (concat "rg"
                       " --no-config"
                       " --color=always"
                       " --hidden"
                       " --colors 'match:fg:yellow'"
                       " --colors 'match:style:nobold'"
                       " --no-heading"
                       " -S -n %s %s %s"))
         (helm-rg-default-extra-args "--hidden"))))
