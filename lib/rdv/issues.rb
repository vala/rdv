module Rdv
  class Issues
    attr_accessor :client, :repo

    def initialize client, repo
      self.client = client
      self.repo = repo
    end

    # Creates issues from the current themes
    def create_issues themes
      issues = themes.reduce([]) do |issues, theme|
        main_label = theme.name
        issues + theme.list.map do |issue|
          # Add theme as the first issue's tag
          issue.tags.unshift(main_label)
          # Create issue
          create_issue(issue)
        end
      end

      issues.compact
    end

    def create_issue issue
      # Serialize the issue to compare it to existing ones
      serialized = serialize_issue(issue.name, issue.tags)
      # If issue already exist, don't create it
      if (existing = existing_issues[serialized])
        puts ("Issue \"#{ issue.name }\" not created, already exists " +
          "as ##{ existing.number } / #{ existing.html_url }").red
        return
      end
      # Create issue in repo
      client.create_issue(repo, issue.name, issue.content, {
        labels: issue.tags, assignee: issue.user
      })
    rescue Octokit::UnprocessableEntity => e
      data = e.response_body
      # Tell that issue couldn't be created
      puts "Couldn't create issue \"#{ issue.name }\", #{ data.message }.".red
      # Display each field with errors
      data.errors.each do |error|
        puts "- #{ error.code } #{ error.field } #{ error.value }".red
      end
      # Ensure nil is returned so compacting issues array will remove it
      # from created ones
      nil
    end

    # Retrieves all existing issues for the current repo and stores them
    # in a hash with the key being some kind of unique identifier
    #
    def existing_issues
      @existing_issues ||=
        client.list_issues(repo).reduce({}) do |hash, issue|
          hash[serialize_issue(issue.title, issue.labels.map(&:name))] = issue
          hash
        end
    end

    def serialize_issue title, labels
      "#{ title }-#{ labels.sort.join(":") }"
    end

    def self.create_from client, repo, themes
      new(client, repo).create_issues(themes)
    end
  end
end