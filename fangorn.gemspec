$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fangorn/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fangorn"
  s.version     = Fangorn::VERSION
  s.authors     = ["Carlos David González Abraham"]
  s.email       = ["carlosdavid@gonzalez-abraham.com.mx"]
  s.homepage    = "https://github.com/carvid/fangorn"
  s.summary     = "Fangorn protect his forrest."
  s.description = "Fangorn protect his forrest."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "activerecord", ">= 3.0.0"

  s.add_development_dependency "sqlite3"
end
