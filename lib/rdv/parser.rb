require "rdv/object"

module Rdv
  class Parser
    def self.parse data
      (@parser ||= self.new).parse(data)
    end

    def parse data
      blocks = find_blocks(data)
      blocks.each(&:build)
      blocks
    end

    def find_blocks text
      text.each_line.reduce([]) do |blocks, line|
        # If line starts with no tab but has content, we start a new block
        if line.match(/^[^\s]+/)
          blocks << Object::Block.new(line)
        # If we have a content line that starts with one or more tabs, we feed
        # last existing block, if we already have one
        elsif line.length > 0 && blocks.length > 0
          blocks.last.add_line(line)
        end

        blocks
      end
    end
  end
end