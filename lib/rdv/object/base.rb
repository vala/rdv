module Rdv
  module Object
    class Base
      def clean str
        str.gsub(/^\->?\s+/, "").gsub(/(\s*\:)??$/, "").strip
      end

      def capitalize str
        str.strip.split(" ").map(&:capitalize).join(" ")
      end

      def trim_indentation str
        str.gsub(/^\s{2}/, "")
      end
    end
  end
end