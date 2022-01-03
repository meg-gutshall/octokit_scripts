# List repos to apply labels to below
repo_names = [
  "tester"
]

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

# Remove labels
remove_labels = {
  "bug",
  "documentation",
  "duplicate",
  "enhancement",
  "good first issue",
  "help wanted",
  "invalid",
  "question",
  "wontfix"
}
