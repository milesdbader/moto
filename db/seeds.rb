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
Recipe.destroy_all
ChallengeIngredient.destroy_all
Challenge.destroy_all
Player.destroy_all
User.destroy_all

puts 'Database empty'


puts 'Generating users'

miles = User.new(
  email: 'milesdbader@gmail.com',
  password: '123456789',
  username: 'milesdbader'
)
image = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582649852/zgx0i2maxdfapypnnjnb.png')
miles.photo.attach(io: image, filename: 'seed')

eyal = User.new(
  email: 'eyalcohen2524@gmail.com',
  password: '123456789',
  username: 'eyalcohen2524'
)
image1 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582649834/jbobeqwfhroeb98b90dl.jpg')
eyal.photo.attach(io: image1, filename: 'seed')


tamara = User.new(
  email: 'tara_art@live.com',
  password: '123456789',
  username: 'tara_art'
)
image2 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582649798/djrvmuhn41pxpdcsqekd.jpg')
tamara.photo.attach(io: image2, filename: 'seed')

david = User.new(
  email: 'david.stranders@gmail.com',
  password: '123456789',
  username: 'davidstranders'
  )
image3 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582627158/Z9JySKnsW8qJkaCyPrtDvzZU.jpg')
david.photo.attach(io: image3, filename: 'seed')

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
    p Recipe.create!(name: name, image_url: image)
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


def generate_challenges
  # mode, challenger, opponent
  future = Date.new(2021, 1, 1)
  miles = User.find_by(username: 'milesdbader')
  eyal = User.find_by(username: 'eyalcohen2524')
  c = Challenge.build!(miles, eyal, mode: 'classic', accepted: true, expiration: future)

end

generate_challenges



