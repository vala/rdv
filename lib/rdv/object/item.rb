module Rdv
  module Object
    class Item < Base
      attr_accessor :name, :content, :raw_content, :user, :tags

      def initialize name
        @name = name
        @raw_content = []
        @tags = []
      end

      def add_line line
        @raw_content << line
      end

      def build
        # Clean name and store it back
        @name = clean(@name.strip)
        # Fetch contents
        contents = @raw_content.reduce([]) do |list, line|
          line = trim_indentation(line)
          list << line
          list
        end.join("").strip.lines

        if contents.last.match(/^\|/)
          @tags = contents.pop.split("|")[1..-1].map do |tag|
            capitalize(tag)
          end.compact
        end

        @content = contents.join

        # If a @user tag is found in the issue name, strip it and store it as
        # the assignee user login
        if (user = @name.match(/@(\w+)$/))
          @user = user[1]
          # Clean username from item name
          @name = @name.gsub(/@(\w+)$/, "").strip
        end
      end
    end
  end
end