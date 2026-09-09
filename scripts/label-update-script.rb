require "dotenv/load"

require "active_support"
require "active_support/core_ext"

require "octokit"
require "colorize"
require "pry"

client = Octokit::Client.new(:access_token => ENV['OCTO_TOKEN'], auto_paginate: true)
user = client.user
repos = client.repos(user.login)

# Uncomment two lines below if relabeling repos from a user account
# user = client.user
# repos = client.repos(user.login)
# Uncomment two lines below if relabeling repos from an organization account
from_org_name = "virtual-coffee"
repos = client.org_repos(from_org_name)

# Set the `search_params` variable below to hold your repo name as a string
search_params = "virtualcoffee"

repos.select! do |repo|
  repo.name.downcase.include?(search_params)
end
puts "\nYou've selected the following repos to relabel: \n".colorize(:light_magenta)

repos.collect do |repo|
  puts repo.full_name.colorize(:bright_white) + "  >>  ".colorize(:light_yellow) + "Last updated on ".colorize(:light_magenta) + repo.updated_at.strftime("%m/%d/%Y").colorize(:light_yellow)
end
puts "\nTotal number of search results: ".colorize(:light_magenta) + repos.count.to_s.colorize(:light_yellow)

# This stopped me accidentally breaking everything, remove the "return" line to continue the program's execution.
return

# Labels to remove
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

repos.each do |repo|
  old_labels.each do |old_label|
    client.delete_label!(repo.full_name, old_label)
  end
end

# Labels to add
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
new_vc_labels = [
  {
    name: "accessibility",
    color: "0366d6",
    description: "Follows a11y best practices"
  },
  {
    name: "channel challenge team",
    color: "d4c5f9",
    description: "Reserved for the Channel Challenge team"
  },
  {
    name: "chore",
    color: "4f08ac",
    description: "Miscellaneous tasks"
  },
  {
    name: "content",
    color: "BC4183",
    description: "Content additions, removals, or updates"
  },
  {
    name: "content: members page",
    color: "BC4183",
    description: "Concerning the members page"
  },
  {
    name: "content: member resources",
    color: "BC4183",
    description: "Concerning member resources"
  },
  {
    name: "dependency",
    color: "4f08ac",
    description: "Updates or fixes a dependency"
  },
  {
    name: "discussion",
    color: "c5def5",
    description: "Not ready for development"
  },
  {
    name: "full members only",
    color: "d4c5f9",
    description:
      "Reserved for members who have attended a Coffee Chat and are in our Slack"
  },
  {
    name: "good first issue",
    color: "008672",
    description: "Reserved for first-time contributors"
  },
  {
    name: "hacktoberfest",
    color: "c96502",
    description: "Reserved for Hacktoberfest"
  },
  {
    name: "hacktoberfest-accepted",
    color: "c96502",
    description: "Marks as accepted for Hacktoberfest"
  },
  {
    name: "help wanted",
    color: "008672",
    description: "Free to be worked on -- pick me!"
  },
  {
    name: "infrastructure team",
    color: "d4c5f9",
    description: "Reserved for the Infrastructure team"
  },
  {
    name: "learners only",
    color: "008672",
    description:
    "Reserved for people new to coding and/or open-source contributions"
  },
  {
    name: "maintenance",
    color: "4f08ac",
    description: "Maintenance tasks and refactoring"
  },
  {
    name: "no code",
    color: "0366d6",
    description: "Does not require code knowledge"
  },
  {
    name: "on hold",
    color: "cfd3d7",
    description: "Being held up or blocked by something"
  },
  {
    name: "triage",
    color: "c5def5",
    description: "Needs review by `CODEOWNERS`"
  }
]

repos.each do |repo|
  new_vc_labels.each do |new_label|
    client.add_label(repo.full_name, new_label[:label], new_label[:color], { description: new_label[:description] })
  end
end
puts "\n#{repos.count.to_s} repos were relabeled!".colorize(:light_green)
