require "dotenv/load"

require "active_support"
require "active_support/core_ext"

require "octokit"
require "colorize"
require "pry"

# !NOTE: Right now this script is set up to transfer repos from a user account to an organization account. Read the comments below carefully if you want to change it.

client = Octokit::Client.new(:access_token => ENV['OCTO_TOKEN'], auto_paginate: true)
# p client

# Fetch the user
user = client.user
# p user

# Load all the repos
repos = client.repos(user.login)
# search_params = {
  #   include: %i[v-000 rails intro],
  #   exclude: %i[js]
# }

# Filter the list of repos you're going to transfer
# ! Be sure to downcase the search parameter
repos.select! do |repo|
  ## Options include:
  # repo.fork?
  # repo.private?
  repo.name.downcase.include?('box-model')
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
  client.transfer_repo(repo.full_name, ENV['ORG_TOKEN'], {
    accept: Octokit::Preview::PREVIEW_TYPES[:transfer_repository]
  })
end

# Print success message
puts "\n#{repos.count.to_s} repos were transferred!".colorize(:light_green)
