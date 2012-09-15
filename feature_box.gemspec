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
  s.summary     = "Feature request service."
  s.description = "FeatureBox is a feature request service written using Ruby on Rails framework. It is an open source analog of VoteBox - part of the DropBox. It is designed to be flexible and customizable and intended to be easily integrated into your website. It uses popular gems like CanCan and Devise."

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

