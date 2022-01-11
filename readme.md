# Octokit Script

This is a WIP repo to house some Octokit Ruby scripts I've created that automate actions I regularly need and mass actions in my GitHub accounts.

**UPDATE as of 01/10/22:** I cleaned up the scripts a bit and tried to make the directions for using them clearer. Any open source commits are welcome, just please send PRs to the `dev` branch. Thank you!

## Usage

Running the script:

```bash
ruby scripts/label-update-script.rb
ruby scripts/repo-transfer-script.rb
```

I **highly** suggest reading through the rest of the section below in case the code comments aren't enough. This is very much still a work in progress!

### Label Update Script

Set the `repo_name` variable on line 16 to match the name of the repo in which you want to change the labels. It can be a partial or exact match—it will still appear in the list of selected repos after you run the script.

On line 31 you'll find the variable `old_labels` which is an array of GitHub's default labels. Remove any that you want to keep or leave them as is if you want to delete them all. On line 50 is the `new_labels` variable. This is an array which holds my default labels. Again, change this list as you wish. The colors are in HEX format without the leading `#` and [GitHub-compatible emoji](https://github.com/ikatyang/emoji-cheat-sheet) are allowed to be used. Make sure the values are in String format.

Leave the `return` on line 28 uncommented to see a preview of the repo(s) you selected in your search printed to the terminal. Comment it out to run the entire script.

#### PAT Scopes for Label Update

- repo and all subscopes
- delete_repo

### Repo Transfer Script

This script works much like the above except you can use it to transfer repos from your User account to an Organization you own, between Organizations you own, or from an Organization you own to your User account.

If you're transferring repos out from your user account, make sure lines 16 and 17 are uncommented. If you're transferring repos out from your organization account, make sure lines 19 and 20 are uncommented. Then, change the value of `from_org_name` to the path name of your GitHub organization. You can find it in the URL when you visit your org:

```bash
https://github.com/{org-name}
https://github.com/orgs/{org-name}/repositories
```

If you're transferring repos into your user account, make sure line 24 is uncommented. If you're transferring repos into your organization account, make sure line 26 uncommented. Again, change the value of `to_org_name` to the path name of to GitHub organization you wish to select.

Set the `search_params` variable on line 26 to match the name of the repo in which you want to change the labels. It can be a partial or exact match—it will still appear in the list of selected repos after you run the script.

Leave the `return` on line 42 uncommented to see a preview of the repo(s) you selected in your search printed to the terminal. This can be helpful in visually determining the best parameters to pass into the script to yield the repos you want. Comment out line 42 to run the entire script.

#### PAT Scopes for Repo Transfer

- repo and all subscopes
- admin:org and all subscopes
- delete_repo

### Generate and Secure an OAuth Token

Make a copy of the `.env.example` file and rename it to `.env`. This is where you'll save your GitHub Personal Access Token (PAT), an alternative to using passwords for authentication to GitHub. You **must** rename the file to `.env` so git ignores it and will not send it to your remote copy of your repo. You want to protect your access tokens as they allow _passwordless access_ to your GitHub account!

Depending on which script you want to run, you'll need to select different scopes for your token. The needed PAT scopes are mentioned in each section above. If you want to cover all your bases, here is a complete list of scopes your need to enable to run all scripts in this program:

- repo and all subscopes
- admin:org and all subscopes
- delete_repo

Lastly, it's easy to create a PAT! Learn how by reading GitHub's article [_Creating a personal access token_](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token). For security reasons, I highly recommend setting an expiration date on every token you create. You will receive email reminders when your token is about to expire, but it may not be as clear if you token is co-opted for nefarious uses.

## Future Plans

I would like to turn this into a Ruby gem or CLI at the very least. More details and [ideas](gem.md) can be found in my [future-features](/docs/future-features.md) file.
