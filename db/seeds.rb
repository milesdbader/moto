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

Ingredient.destroy_all
ChallengeIngredient.destroy_all
Challenge.destroy_all
Player.destroy_all
User.destroy_all
Recipe.destroy_all

puts 'Database empty'

puts 'Generating users'

miles = User.new(
  email: 'milesdbader@gmail.com',
  password: '123456789',
  username: 'milesdbader'
)
eyal = User.new(
  email: 'eyalcohen2524@gmail.com',
  password: '123456789',
  username: 'eyalcohen2524'
)
tamara = User.new(
  email: 'tara_art@live.com',
  password: '123456789',
  username: 'tara_art'
)
david = User.new(
  email: 'david.stranders@gmail.com',
  password: '123456789',
  username: 'davidstranders'
  )

miles.save!
eyal.save!
tamara.save!
david.save!

puts 'Users generated'
puts "You now have #{User.count} users"

puts 'Generating recipes'

def david_made_this
  base_url = 'https://minimalistbaker.com/recipe-index/'
  doc = Nokogiri::HTML(open(base_url).read)
  doc.css('.entry').map do |recipe|
    image = recipe.css('.thumbnail-wrapper img')[0].attributes['data-original'].value
    name = recipe.css('.entry-title').text
    Recipe.create!(name: name, image_url: image)
  end
end

david_made_this

puts "#{Recipe.count} recipes created"
puts "Generating ingredients"
protein_ingredients = ['Corn', 'Potatoes', 'Broccoli', 'Cauliflower', 'Peas', 'Asparagus', 'Salmon', 'Beef', 'Chicken', 'Tuna', 'Pork', 'Turkey', 'Halibut', 'Spelt', 'Teff', 'Black beans', 'Lima beans', 'Chinese cabbage', 'Bison']
grain_ingredients = ['Chickpeas', 'Soybeans', 'Artichoke', 'Potato', 'Parsnips', 'Broccoli', 'Pumpkin', 'Quinoa', 'Almonds', 'Pistachios']
vegetable_ingredients = ['Spinach', 'Bell peppers', 'Kale', 'Alfalfa sprouts', 'Sweet potatoes', 'Broccoli', 'Endive', 'Fennel', 'Basil', 'Thyme', 'Sage', 'Rosemary', 'Arugula', 'Chives' 'Peas', 'Beets', 'Carrots', 'Tomato', 'Garlic', 'Onion', 'Cauliflower', 'Seaweed']
dairy_ingredients = ['Greek yogurt', 'Cottage cheese', 'Milk', 'Butter', 'Buttermilk', 'Custard', 'Curd', 'Cream cheese', 'Paneer', 'Sour milk']

protein_ingredients.each do |ingredient|
  Ingredient.create(name: ingredient, category: 'protein')
end
grain_ingredients.each do |ingredient|
  Ingredient.create(name: ingredient, category: 'grain')
end
vegetable_ingredients.each do |ingredient|
  Ingredient.create(name: ingredient, category: 'vegetable')
end
dairy_ingredients.each do |ingredient|
  Ingredient.create(name: ingredient, category: 'dairy')
end

puts "Created #{Ingredient.count} ingredients"

puts "creating a challenge"
Challenge.build!(miles, david, attributes = {accepted: true, expiration: Time.new(2020, 03, 05), voting_end: Time.new(2020, 03, 10), mode: 'creative' })
puts "#{Challenge.count} created"
