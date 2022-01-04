## Docs: http://octokit.github.io/octokit.rb/

# Run: gem install octokit colorize
require "octokit"
require "json"
require "colorize"
require "pry"
require "dotenv/load"

## Generate a token at:
# https://github.com/settings/tokens
#
# Make sure it has a scope of:
# - Full control of private repos
# - User authentication

# Connect to GitHub account
client = Octokit::Client.new(:access_token => ENV['OCTO_TOKEN'], auto_paginate: true)
# p client

# Fetch the user
user = client.user
# p user

# Load all the repos
repos = client.repos(user.login)
# p repos.name

# Select repo(s) you're going to change
# ! Be sure to downcase the search parameter
# May want to use Regex here
repos.select! do |repo|
  repo.name.downcase.include?('tester')
end

# Tell us which repo(s) we've selected
puts "\nYou've selected the following repos to relabel: \n".colorize(:light_magenta)

repos.collect do |repo|
  puts repo.full_name.colorize(:bright_white) + "  >>  ".colorize(:light_yellow) + "Last updated on ".colorize(:light_magenta) + repo.updated_at.strftime("%m/%d/%Y").colorize(:light_yellow)
end

puts "\nTotal number of search results: ".colorize(:light_magenta) + repos.count.to_s.colorize(:light_yellow)

# This stopped me accidentally breaking everything, remove the "return" line to continue the program's execution.
return

# Remove labels
old_labels = [
  "bug",
  "documentation",
  "duplicate",
  "enhancement",
  "good first issue",
  "help wanted",
  "invalid",
  "question",
  "wontfix"
]

# Remove GitHub's default labels
repos.each do |repo|
  old_labels.each do |old_label|
    Octokit.delete_label!(repo, old_label)
  end
end

# Create default labels
new_labels = [
  {
    name: "accessibility :wheelchair:",
    color: "C93377",
    description: "Follow a11y best practices"
  },
  {
    name: "dependencies :deciduous_tree:",
    color: "EE1C75",
    description: "Pull requests that update a dependency file"
  },
  {
    name: "good first issue :100:",
    color: "2074C4",
    description: "Good for newcomers"
  },
  {
    name: "help wanted :sos:",
    color: "D93F0B",
    description: "Up for grabs"
  },
  {
    name: "high priority :rotating_light:",
    color: "B60205",
    description: "Highest priority issues"
  },
  {
    name: "status: blocked :no_entry_sign:",
    color: "782975",
    description: "Something else is blocking this"
  },
  {
    name: "status: on hold :hand:",
    color: "375071",
    description: "Waiting on a decision or review"
  },
  {
    name: "status: pending :clock1030:",
    color: "0D6E0E",
    description: "In a waiting state"
  },
  {
    name: "type: architecture :classical_building:",
    color: "7057FF",
    description: "Changes to code architecture"
  },
  {
    name: "type: bug :bug:",
    color: "E21D20",
    description: "Something isn't working"
  },
  {
    name: "type: chore :broom:",
    color: "1D7CBB",
    description: "Misc."
  },
  {
    name: "type: content :speech_balloon:",
    color: "C83462",
    description: "Concerning text and literals"
  },
  {
    name: "type: documentation :bookmark_tabs:",
    color: "5A44A0",
    description: "Improvements or additions to documentation"
  },
  {
    name: "type: enhancement :sparkles:",
    color: "026A74",
    description: "New feature or request"
  },
  {
    name: "type: maintenance :wrench:",
    color: "7D2B61",
    description: "Fixes to and refactoring codebase"
  },
  {
    name: "type: needs discussion :speaking_head:",
    color: "0052CC",
    description: "Further information is needed"
  },
  {
    name: "type: security :lock:",
    color: "E21D20",
    description: "Implement a security patch"
  },
  {
    name: "type: testing :white_check_mark:",
    color: "DB5942",
    description: "Add test specs"
  },
  {
    name: "type: ui/ux :lipstick:",
    color: "1A8481",
    description: "Site styling and appearances"
  }
]

# Add my default labels
repos.each do |repo|
  client.transfer_repo(repo.full_name, STUDY_KIT_ORG, {
    accept: Octokit::Preview::PREVIEW_TYPES[:transfer_repository]
  })
end

# Print success message
puts "\n#{repos.count.to_s} repos were transferred!".colorize(:light_green)
