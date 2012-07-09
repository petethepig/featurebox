remove_file "public/index.html"
gem "feature_box", :path=>'./../../'

if yes?("[y] for standalone, [n] for existing") 
  generate "feature_box:standalone"
else
  
  @model_name = ask("Choose user model name [User]")
  @model_name = "User" if @model_name.empty?

  gem "devise"
  generate "devise:install"
  generate "devise", @model_name
  

  generate "controller", "home"
  route "root :to => 'home#index'"

  remove_file "app/views/layouts/application.html.erb"
  remove_file "app/views/home/index.html.erb"
  remove_file "app/helpers/application_helper.rb"

  copy_file File.expand_path(File.dirname(__FILE__))+"/existing-template/application.html.erb", "app/views/layouts/application.html.erb"
  copy_file File.expand_path(File.dirname(__FILE__))+"/existing-template/index.html.erb", "app/views/home/index.html.erb"
  template  File.expand_path(File.dirname(__FILE__))+"/existing-template/application_helper.rb", "app/helpers/application_helper.rb"
  
  generate "feature_box:existing", @model_name

end