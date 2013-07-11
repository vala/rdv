module Rdv
  module Object
    class Block < Base
      attr_accessor :name, :list, :raw_list

      def initialize header
        @name = capitalize(header)
        @raw_list = []
      end

      def add_line(line)
        @raw_list << line
      end

      def build
        @list = @raw_list.reduce([]) do |list, line|
          line = trim_indentation(line)

          if line.match(/^[^\s]+/)
            list << Item.new(line)
          elsif list.length > 0 && line.length > 0
            list.last.add_line(line)
          end

          list
        end

        @list.each(&:build)

        @name = clean(@name)
      end
    end
  end
end