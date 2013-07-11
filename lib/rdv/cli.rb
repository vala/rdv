require "thor"
require "io/console"
require "octokit"

module Rdv
  class CLI < Thor
    desc "convert REPOSITORY FILE", "Converts a .rdv file to Github issues"
    def convert repo, file
      puts "Converting file : #{ file } to issues in #{ repo }".yellow
      repo = repo
      # Parse themes and issues from input file
      themes = Parser.parse File.read(file)

      puts "Please enter your Github credentials.".green
      # Next actions need to be retriable, so we wrap them to be able to
      # call it back if authorization fails
      remote_actions = lambda do
        client = build_github_client
        # Convert themes to issues and count them
        issues = Issues.create_from(client, repo, themes)
        puts "Created #{ issues.length } issues".yellow
      end
      # Request user's Github credentials to connect to API and build client
      remote_actions.call
    rescue Octokit::Unauthorized, Octokit::Forbidden => e
      case e.class.name
      # When user fails to log in, let him try again
      when "Octokit::Unauthorized"
        puts "Bad credentials ... please try again.".red
        remote_actions.call
      # When user fails too many times, exit
      when "Octokit::Forbidden"
        puts "Too many attempts ... please try again later.".red
        exit 1
      end
    end

    protected

    def build_github_client
      print "Username : ".green
      username = STDIN.gets.chop
      print "Password : ".green
      password = STDIN.noecho(&:gets).chop
      puts ""
      Octokit::Client.new(login: username, password: password)
    end
  end
end