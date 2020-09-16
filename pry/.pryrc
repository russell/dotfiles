# -*- mode: ruby -*-
# ideas sourced from https://dev.to/thiagoa/ruby-and-emacs-tip-advanced-pry-integration-33bk
if ENV['INSIDE_EMACS']
  Pry.config.correct_indent = false
  Pry.config.pager = false
end

Pry.config.editor = ENV['VISUAL']
