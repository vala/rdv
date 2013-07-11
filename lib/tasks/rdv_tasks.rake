require "rdv"

namespace :rdv do
  task :example do
    filepath = File.expand_path "../../../samples/example.rdv", __FILE__
    parsed = Rdv::Parser.parse(File.read(filepath))
  end

  task :parse do
    contents = File.read ENV['FILE']
    blocks = Rdv::Parser.parse(contents)

    blocks.each do |block|
      puts block.inspect
    end
  end
end