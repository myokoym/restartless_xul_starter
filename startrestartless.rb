#!/usr/bin/env ruby

require "fileutils"

if ARGV.size < 1
  $stderr.puts("Usage: #{$0} PROJECT_NAME")
  exit(false)
end
project_name = ARGV[0]

unless File.directory?(project_name)
  system("git",
         "clone",
         "git@github.com:piroor/restartless.git",
         project_name)
end
git_user_name = `git config user.name`.chomp
git_user_email = `git config user.email`.chomp

Dir.chdir(project_name) do
  unless File.file?("LICENSE")
    system("wget",
           "https://mozorg.cdn.mozilla.net/media/MPL/2.0/index.txt")
    FileUtils.mv("index.txt", "LICENSE")
  end
  system("git", "submodule", "update", "--init")
end
