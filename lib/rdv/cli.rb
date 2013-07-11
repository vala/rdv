require "thor"
require "io/console"
require "rdv/core_ext/string"
require "octokit"

module Rdv
  class CLI < Thor
    desc "convert REPOSITORY FILE", "Converts a .rdv file to Github issues"
    def convert repo, file
      puts "Converting file : #{ file } to issues in #{ repo }".yellow
      repo = repo
      # Parse themes and issues from input file
      themes = Parser.parse File.read(file)
      # Request user's Github credentials to connect to API and build client
      client = build_github_client
      # Convert themes to issues and count them
      issues = Issues.create_from(client, repo, themes)
      puts "Created #{ issues.length } issues".yellow
    end

    protected

    def build_github_client
      puts "Please enter your Github credentials.".green
      print "Username : ".green
      username = STDIN.gets.chop
      print "Password : ".green
      password = STDIN.noecho(&:gets).chop
      puts ""

      Octokit::Client.new(login: username, password: password)
    end

    def create_issues themes

    end
  end
end