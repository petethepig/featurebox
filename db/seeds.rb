# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

u = FeatureBox::User.new 
u.email = "admin@example.com"
u.name = "admin"
u.password="admin!"
u.password_confirmation="admin!"
u.admin = true
u.save

