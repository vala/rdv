$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rdv/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rdv"
  s.version     = Rdv::VERSION
  s.authors     = ["Valentin Ballestrino"]
  s.email       = ["vala@glyph.fr"]
  s.homepage    = "http://www.glyph.fr"
  s.summary     = "Small DSL to write issues in plain text"
  s.description = "rdv converts plain text markup into github issues and post them to the desired repository"
  s.license     = "MIT"

  s.files = Dir["{bin,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.bindir = "bin"
  s.executables << "rdv"


  s.add_dependency "thor"
  s.add_dependency "octokit"
end
