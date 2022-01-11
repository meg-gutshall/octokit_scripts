require "dotenv/load"

require "active_support"
require "active_support/core_ext"

require "octokit"
require "colorize"
require "pry"

# !NOTE: Right now this script is set up to transfer repos from a user account to an organization account. Read the comments below carefully if you want to change it.

client = Octokit::Client.new(:access_token => ENV['OCTO_TOKEN'], auto_paginate: true)

# TRANSFERRING FROM...
# Uncomment two lines below if tranferring repos from a user account
user = client.user
repos = client.repos(user.login)
# Uncomment two lines below if tranferring repos from an organization account
# from_org_name = "org-name"
# repos = client.org_repos(from_org_name)

# TRANSFERRING TO...
# Uncomment the line below if tranferring repos to a user account
# user = user.login
# Uncomment the line below if tranferring repos to an organization account
to_org_name = "org-name"

# Set the `search_params` variable below to hold your repo name as a string
search_params = "repo name"

repos.select! do |repo|
  repo.name.downcase.include?(search_params)
end
puts "\nYou've selected the following repos to be transferred: \n".colorize(:light_magenta)

repos.collect do |repo|
  puts repo.full_name.colorize(:bright_white) + "  >>  ".colorize(:light_yellow) + "Last updated on ".colorize(:light_magenta) + repo.updated_at.strftime("%m/%d/%Y").colorize(:light_yellow)
end
puts "\nTotal number of search results: ".colorize(:light_magenta) + repos.count.to_s.colorize(:light_yellow)

# This stopped me accidentally breaking everything, remove the "return" line to actually perform the transfers.
return

repos.each do |repo|
  client.transfer_repo(repo.full_name, to_org_name, {
    accept: Octokit::Preview::PREVIEW_TYPES[:transfer_repository]
  })
end
puts "\n#{repos.count.to_s} repos were transferred!".colorize(:light_green)
