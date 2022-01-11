# Future Features

## Architecture

- [ ] Create dotenv rake task to load dotenv variables(?)
- [ ] Rewrite current scripts using GitHub's REST API and Ruby's HTTP API (Octokit.rb is no longer being maintained)
  - [GitHub REST API](https://docs.github.com/en/rest)
  - [Net::HTTP](https://ruby-doc.org/stdlib-3.0.2/libdoc/net/http/rdoc/Net/HTTP.html)
- [ ] Create object-oriented structuring throughout app

## Implementation

- [ ] Create a Regex pattern to search/filter
- [ ] Add `auto_paginate: true` to the authentication action so as not to limit the number of results displayed at one time

## Octokit Search and Filtering Options

```ruby
repos = client.repos(user.login, search_params)
search_params = {
  include: %i[v-000 rails intro],
  exclude: %i[js]
}
```

```ruby
repos.select! do |repo|
  ## Options include:
  # repo.fork?
  # repo.private?
  repo.name.downcase.include?(repo_name)
end
```

## Reference

- [GitHub REST API Reference](https://docs.github.com/en/rest/reference)
- [GitHub GraphQL API Reference](https://docs.github.com/en/graphql/reference)
- [Transfer a repository](https://docs.github.com/en/rest/reference/repos#transfer-a-repository)
