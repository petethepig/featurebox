$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "feature_box/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "feature_box"
  s.version     = FeatureBox::VERSION
  s.authors     = ["Dmitry Filimonov"]
  s.email       = ["me@dfilimonov.com"]
  s.homepage    = "http://featurebox.me/"
  s.summary     = "Flexible feature request service."
  s.description = "Flexible feature request service."

  s.require_paths = ['lib']

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "README.rdoc", "CHANGELOG.rdoc"]
  s.test_files = Dir["test/**/*"]


  s.add_dependency "devise", ">= 2.1.0"
  s.add_dependency "rails", "~> 3.2.6"
  s.add_dependency "cancan", "<=1.6.7"


  s.add_dependency "haml", "~> 3.1.6"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails", "~> 3.2.3"
  s.add_dependency "uglifier", ">= 1.0.3"

end

