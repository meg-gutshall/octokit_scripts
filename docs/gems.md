# Gems

The following are some gems I'm using throughout the app and notes about them:

## Octokit Ruby

Ruby toolkit for the GitHub API

GitHub Repo: [https://github.com/octokit/octokit.rb](https://github.com/octokit/octokit.rb)

## dotenv

A Ruby gem to load environment variables from `.env`

GitHub Repo: [https://github.com/bkeepers/dotenv](https://github.com/bkeepers/dotenv)

## Notes

**REMEMBER!!** You need to actually _load_ the `.env` file by calling either:

```ruby
require 'dotenv/load'
```

OR

```ruby
require 'dotenv'
Dotenv.load
```

As early as possible in the application bootstrap process.

Alternatively, you can use the `dotenv` executable to launch the application:

```bash
dotenv label-update-script.rb
```

To ensure `dotenv` is loaded in rake, load the tasks:

```ruby
require 'dotenv/tasks'

task mytask: :dotenv do
  # things that require .env
end
```
