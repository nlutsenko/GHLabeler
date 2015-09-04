# GHLabeler
Automatically add labels from a configuration file to a GitHub repo.

## Usage

To update any repository with default labels from `labels.yml` in this repo:

```bash
bundle install
bundle exec ./labeler.rb <Organization/Repository>
```

You can also use custom labels.yml file:
```bash
bundle install
bundle exec ./labeler.rb <Organization/Repository> <.yml File Path>
```