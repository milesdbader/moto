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

ChallengeIngredient.destroy_all
print 'ChallengeIngredients, '
Vote.destroy_all
print 'Votes, '
Ingredient.destroy_all
print 'Ingredients, '
Challenge.destroy_all
print 'Challenges, '
Player.destroy_all
print 'Players, '
User.destroy_all
print 'Users, '
Recipe.destroy_all
puts 'Recipes'

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
image3 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582993683/uz6xP9oZqHg5Az4WBZgrZhMN.jpg')
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
  Ingredient.create!(name: ingredient, category: 'protein')
end
grain_ingredients.each do |ingredient|
  Ingredient.create!(name: ingredient, category: 'grain')
end
vegetable_ingredients.each do |ingredient|
  Ingredient.create!(name: ingredient, category: 'vegetable')
end
dairy_ingredients.each do |ingredient|
  Ingredient.create!(name: ingredient, category: 'dairy')
end

puts "Created #{Ingredient.count} ingredients"

puts "creating challenges"

recipe1 = Recipe.first
# these ones are active
Challenge.build!(tamara, david, accepted: true, expiration: Time.new(2020, 03, 05), mode: 'creative', protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(eyal, miles,  accepted: true, expiration: Time.new(2020, 02, 29), mode: 'classic', protein: Ingredient.find_by(name: 'Tuna'), grain: Ingredient.find_by(name: 'Almonds'), dairy: Ingredient.find_by(name: 'Butter'), vegetable: Ingredient.find_by(name: 'Kale'))
Challenge.build!(tamara, eyal, accepted: true, expiration: Time.new(2020, 02, 28), mode: 'classic', protein: Ingredient.find_by(name: 'Salmon'), grain: Ingredient.find_by(name: 'Pistachios'), dairy: Ingredient.find_by(name: 'Milk'), vegetable: Ingredient.find_by(name: 'Broccoli'))

# these ones are pending
Challenge.build!(tamara, miles, accepted: false, mode: 'creative', protein: Ingredient.find_by(name: 'Tuna'), grain: Ingredient.find_by(name: 'Almonds'), dairy: Ingredient.find_by(name: 'Butter'), vegetable: Ingredient.find_by(name: 'Kale'))
Challenge.build!(david, tamara, accepted: false, mode: 'classic', protein: Ingredient.find_by(name: 'Tuna'), grain: Ingredient.find_by(name: 'Almonds'), dairy: Ingredient.find_by(name: 'Butter'), vegetable: Ingredient.find_by(name: 'Kale'))
Challenge.build!(miles, tamara, accepted: false, mode: 'classic', protein: Ingredient.find_by(name: 'Tuna'), grain: Ingredient.find_by(name: 'Almonds'), dairy: Ingredient.find_by(name: 'Butter'), vegetable: Ingredient.find_by(name: 'Kale'))

Challenge.build!(miles, david, accepted: true, expiration: Time.new(2020, 03, 02), mode: 'creative', protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582803104/vi3nwpxzozuk1zsdwwo1.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582803097/tfxxbzfqw9tfx7hj4aug.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "Yes, I didn't use the ingredients, but at least it's delicious!", title: "One Badass Breaky")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "I used all of the ingredients in this dish and borrowed my sister's camera to make it look nice. Please vote for me!", title: "GREATEST FRENCH TOAST")

Challenge.build!(david, eyal, accepted: true, expiration: Time.new(2020, 03, 02), mode: 'creative', protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582803104/vi3nwpxzozuk1zsdwwo1.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582803097/tfxxbzfqw9tfx7hj4aug.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "Yes, I didn't use the ingredients, but at least it's delicious!", title: "One Badass Breaky")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "I used all of the ingredients in this dish and borrowed my sister's camera to make it look nice. Please vote for me!", title: "GREATEST FRENCH TOAST")

Challenge.build!(eyal, tamara, accepted: true, expiration: Time.new(2020, 03, 02), mode: 'creative', protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582803104/vi3nwpxzozuk1zsdwwo1.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582803097/tfxxbzfqw9tfx7hj4aug.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "Yes, I didn't use the ingredients, but at least it's delicious!", title: "One Badass Breaky")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "I used all of the ingredients in this dish and borrowed my sister's camera to make it look nice. Please vote for me!", title: "GREATEST FRENCH TOAST")

puts "#{Challenge.count} created"

