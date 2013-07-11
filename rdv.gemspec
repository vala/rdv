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
  s.summary     = "Small DSL to write things down"
  s.description = "Small DSL to write things down"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "thor"
  s.add_dependency "octokit"
end
