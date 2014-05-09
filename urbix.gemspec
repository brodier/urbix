$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "urbix/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "urbix"
  s.version     = Urbix::VERSION
  s.authors     = ["Bernard Rodier"]
  s.email       = ["bernard.rodier@gmail.com"]
  s.licenses    = ['MIT']

  s.homepage    = "http://github.com/brodier/urbix.git"
  s.summary     = "Rails extention to provide usefull tools to manipulate model belong_to others"
  s.description = "Urbix provide act_as_view methods that will provide extention attribute 
  on model with all its belongs_to relation. It also provide helper for building form with 
  input helper based on these relation, query filters and other usefull methods"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency 'rails', '~> 4.0'
  s.add_runtime_dependency 'log4r', '~> 1.0' 
  s.add_development_dependency 'sqlite3', '~> 1.0' 
end
