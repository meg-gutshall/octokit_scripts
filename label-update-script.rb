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
    client.delete_label!(repo.full_name, old_label)
  end
end

# Create default labels
new_labels = [
  {
    label: "accessibility :wheelchair:",
    color: "C93377",
    description: "Follow a11y best practices"
  },
  {
    label: "dependencies :deciduous_tree:",
    color: "EE1C75",
    description: "Pull requests that update a dependency file"
  },
  {
    label: "good first issue :100:",
    color: "2074C4",
    description: "Good for newcomers"
  },
  {
    label: "help wanted :sos:",
    color: "D93F0B",
    description: "Up for grabs"
  },
  {
    label: "high priority :rotating_light:",
    color: "B60205",
    description: "Highest priority issues"
  },
  {
    label: "status: blocked :no_entry_sign:",
    color: "782975",
    description: "Something else is blocking this"
  },
  {
    label: "status: on hold :hand:",
    color: "375071",
    description: "Waiting on a decision or review"
  },
  {
    label: "status: pending :clock1030:",
    color: "0D6E0E",
    description: "In a waiting state"
  },
  {
    label: "type: architecture :classical_building:",
    color: "7057FF",
    description: "Changes to code architecture"
  },
  {
    label: "type: bug :bug:",
    color: "E21D20",
    description: "Something isn't working"
  },
  {
    label: "type: chore :broom:",
    color: "1D7CBB",
    description: "Misc."
  },
  {
    label: "type: content :speech_balloon:",
    color: "C83462",
    description: "Concerning text and literals"
  },
  {
    label: "type: documentation :bookmark_tabs:",
    color: "5A44A0",
    description: "Improvements or additions to documentation"
  },
  {
    label: "type: enhancement :sparkles:",
    color: "026A74",
    description: "New feature or request"
  },
  {
    label: "type: maintenance :wrench:",
    color: "7D2B61",
    description: "Fixes to and refactoring codebase"
  },
  {
    label: "type: needs discussion :speaking_head:",
    color: "0052CC",
    description: "Further information is needed"
  },
  {
    label: "type: security :lock:",
    color: "E21D20",
    description: "Implement a security patch"
  },
  {
    label: "type: testing :white_check_mark:",
    color: "DB5942",
    description: "Add test specs"
  },
  {
    label: "type: ui/ux :lipstick:",
    color: "1A8481",
    description: "Site styling and appearances"
  }
]

# Add my default labels
repos.each do |repo|
  new_labels.each do |new_label|
    client.add_label(repo.full_name, new_label[:label], new_label[:color], { description: new_label[:description] })
  end
end

# Print success message
puts "\n#{repos.count.to_s} repos were relabeled!".colorize(:light_green)
