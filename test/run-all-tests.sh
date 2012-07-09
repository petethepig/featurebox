#!/bin/bash
rm -r standalone
rm -r with-devise-user
rm -r with-devise-person
rails new standalone -m template.rb
rails new with-devise-user -m template.rb
rails new with-devise-person -m template.rb