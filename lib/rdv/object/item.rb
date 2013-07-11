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
          list << line unless line.match(/^\s+$/)
          list
        end.compact

        if contents.last.scan(/\|/).length > 0
          @tags = contents.pop.split("|").map do |tag|
            capitalize(tag)
          end
        end

        @content = contents.join("")

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