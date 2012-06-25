namespace :feature_box do
  
  desc "Seed into database with sample admin credentials"
  task :seed => :environment do
    eval(open("#{FeatureBox::Engine.root}/db/seeds.rb").read)
  end


end