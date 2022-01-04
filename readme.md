# Octokit Script

This is a WIP repo to house some Octokit Ruby scripts I've created that automate actions I regularly need and mass actions in my GitHub accounts.

## Usage

Add a `.env` file to hold your GitHub Personal Authorization Tokens (PATs) and any other secrets you don't want to get out!

### Label Update Script

Replace the parameter on line 32 to match the name of the repo in which you want to change the labels. Starting on line 49 is a list of GitHub's default labels. Remove any that you want to keep or leave them all if you want to delete them all. Starting on line 64 is a list of new labels. These are my defaults. Again, change this list as you wish. Colors are in HEX format without the leading `#` and GitHub-compatible emojis are allowed to be used. Make sure the values are in String format. Uncomment the `return` on line 45 to run the entire script. Leave it commented to see a preview of the repo(s) you selected in your search.

### Repo Transfer Script

This script works much like the above except you can use it to transfer repos from your User account to an Organization you own, between Organizations you own, or from an Organization you own to your User account. You will need to create a PAT for each account involved in the transfer! Use the commented out search parameter options (more to come) to narrow down your list of repositories. Uncomment the `return` on line 49 to run the entire script. Leave it commented to see a preview of the repo(s) you selected in your search.

## Future Plans

I would like to turn this into a Ruby gem or CLI at the very least.
