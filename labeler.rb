#!/usr/bin/env ruby

require 'bundler'
require 'highline/import'
require 'octokit'
require 'yaml'

def main
  repo_name = ARGV[0]
  if repo_name.nil? || repo_name == '-h' || repo_name == '--help'
    say 'Usage: labeler.rb <Organization/Repository> <labels.yml File>'
    exit(1)
  end

  say 'GitHub Access Token'
  access_token = ask('Access Token: ') { |a| a.echo = false }

  gh_client = Octokit::Client.new(:access_token => access_token)
  gh_client.login

  label_file = ARGV[1] || 'labels.yml'
  labels = YAML::load_file(label_file)
  labels.map do |l|
    begin
      gh_client.label(repo_name, l[:name])
      gh_client.update_label(repo_name, l[:name], {:color => l[:color]})
    rescue Octokit::NotFound
      gh_client.add_label(repo_name, l[:name], l[:color])
    end
  end

  puts
  say "Updated all labels for #{repo_name}."
  say "Check out all labels at https://github.com/#{repo_name}/labels"
end

begin
  main
rescue Interrupt
  say 'Exiting...'
end
