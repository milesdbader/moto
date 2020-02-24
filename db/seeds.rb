# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Cleaning the database'

# # Rental.destroy_all
# Package.destroy_all
# User.destroy_all

# puts 'Database empty'


# puts 'Generating users'

# miles = User.new(
#   email: 'milesdbader@gmail.com',
#   password: '123456789',
#   username: 'milesdbader'
# )

# eyal = User.new(
#   email: 'eyalcohen2524@gmail.com',
#   password: '123456789',
#   username: 'eyalcohen2524'
# )


# tamara = User.new(
#   email: 'tara_art@live.com',
#   password: '123456789',
#   username: 'tara_art'
# )

# david = User.new(
#   email: 'david.stranders@gmail.com',
#   password: '123456789',
#   username: 'davidstranders'
#   )

# miles.save!
# eyal.save!
# tamara.save!
# david.save!

# puts 'Users generated'
# puts "You now have #{User.count} users"



def david_made_this
  base_url = 'https://minimalistbaker.com/recipe-index/'
  doc = Nokogiri::HTML(open(base_url).read)
  doc.css('.entry').map do |recipe|
    image = recipe.css('.thumbnail-wrapper img')[0].attributes['data-original'].value
    name = recipe.css('.entry-title').text
    puts "Recipe Name: #{name}\n\n\n"
    puts "Recipe Image Url #{image} \n\n\n"
    # Recipe.create!(name: name, image: image)
  end
end

puts david_made_this.count

