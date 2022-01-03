## Docs: http://octokit.github.io/octokit.rb/

# Run: gem install octokit colorize
require "octokit"
require "json"
require "colorize"
require "pry"

## Generate a token at:
# https://github.com/settings/tokens
#
# Make sure it has a scope of:
# - Full control of private repos
#
# Your GitHub token:
ENV['OCTO_TOKEN']

# Connect to GitHub account
client = Octokit::Client.new(access_token: ENV['OCTO_TOKEN'], auto_paginate: true)

# Load all the repos
repos = client.repos(client.user.login)

# Select repo(s) you're going to change
# ! Be sure to downcase the search parameter
repos.select! do |repo|
  ## Options include:
  # repo.fork?
  # repo.private?
  repo.name.downcase.include?('tester')
end

# Tell us what repos we're about to move
puts "\nYou've selected the following repos to be transferred: \n".colorize(:light_magenta)

repos.collect do |repo|
  puts repo.full_name.colorize(:bright_white) + "  >>  ".colorize(:light_yellow) + "Last updated on ".colorize(:light_magenta) + repo.updated_at.strftime("%m/%d/%Y").colorize(:light_yellow)
end

puts "\nTotal number of search results: ".colorize(:light_magenta) + repos.count.to_s.colorize(:light_yellow)

# This stopped me accidentally breaking everything, remove the "return" line to actually perform the transfers.
return


# Start transferring the repos to the new account
repos.each do |repo|
  client.transfer_repo(repo.full_name, STUDY_KIT_ORG, {
    accept: Octokit::Preview::PREVIEW_TYPES[:transfer_repository]
  })
end

# Print success message
puts "\n#{repos.count.to_s} repos were transferred!".colorize(:light_green)
