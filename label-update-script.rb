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
client = Octokit::Client.new(:access_token => ENV['OCTO_TOKEN'])
p client

# Load all the repos
repos = client.repos(client.user.login)

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
remove_labels = [
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
  remove_labels.map do |repo, label|
    Octokit.delete_label!(repo, label)
  end
end

# Create default labels
default_labels = [
  {
    "name": "accessibility :wheelchair:",
    "description": "Follow a11y best practices",
    "color": "C93377"
  },
  {
    "name": "dependencies :deciduous_tree:",
    "description": "Pull requests that update a dependency file",
    "color": "EE1C75"
  },
  {
    "name": "good first issue :100:",
    "description": "Good for newcomers",
    "color": "2074C4"
  },
  {
    "name": "help wanted :sos:",
    "description": "Up for grabs",
    "color": "D93F0B"
  },
  {
    "name": "high priority :rotating_light:",
    "description": "Highest priority issues",
    "color": "B60205"
  },
  {
    "name": "status: blocked :no_entry_sign:",
    "description": "Something else is blocking this",
    "color": "782975"
  },
  {
    "name": "status: on hold :hand:",
    "description": "Waiting on a decision or review",
    "color": "375071"
  },
  {
    "name": "status: pending :clock1030:",
    "description": "In a waiting state",
    "color": "0D6E0E"
  },
  {
    "name": "type: architecture :classical_building:",
    "description": "Changes to code architecture",
    "color": "7057FF"
  },
  {
    "name": "type: bug :bug:",
    "description": "Something isn't working",
    "color": "E21D20"
  },
  {
    "name": "type: chore :broom:",
    "description": "Misc.",
    "color": "1D7CBB"
  },
  {
    "name": "type: content :speech_balloon:",
    "description": "Concerning text and literals",
    "color": "C83462"
  },
  {
    "name": "type: documentation :bookmark_tabs:",
    "description": "Improvements or additions to documentation",
    "color": "5A44A0"
  },
  {
    "name": "type: enhancement :sparkles:",
    "description": "New feature or request",
    "color": "026A74"
  },
  {
    "name": "type: maintenance :wrench:",
    "description": "Fixes to and refactoring codebase",
    "color": "7D2B61"
  },
  {
    "name": "type: needs discussion :speaking_head:",
    "description": "Further information is needed",
    "color": "0052CC"
  },
  {
    "name": "type: security :lock:",
    "description": "Implement a security patch",
    "color": "E21D20"
  },
  {
    "name": "type: testing :white_check_mark:",
    "description": "Add test specs",
    "color": "DB5942"
  },
  {
    "name": "type: ui/ux :lipstick:",
    "description": "Site styling and appearances",
    "color": "1A8481"
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
