task :environment do
  require "rubygems"
  require "bundler"
  require "bundler/setup"

  require "active_support"
  require "active_support/core_ext"

  require "dotenv/load"
  require "dotenv/tasks"

  require "octokit"
  require "colorize"
  require "pry"

  require "./scripts/label-update-script.rb"
  require "./scripts/repo-transfer-script.rb"
end

# desc "Replaces default GitHub labels with your custom labels"
# task update_labels: :environment do
#   puts "Run update labels task"
#   Add task actions
# end

# desc "Transfers repos between your user/org accounts"
# task transfer_repos: :environment do
#   puts "Run transfer repos task"
#   Add task actions
# end