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
  username: 'tamara'
)
image2 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582649798/djrvmuhn41pxpdcsqekd.jpg')
tamara.photo.attach(io: image2, filename: 'seed')

david = User.new(
  email: 'david.stranders@gmail.com',
  password: '123456789',
  username: 'davidstranders'
  )
image3 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583071281/J2Yy4sgXCicoJr2c6TdgpYwN.jpg')
david.photo.attach(io: image3, filename: 'seed')

# NEW USER SEEDS:


john = User.new(
  email: 'john.harris@gmail.com',
  password: '123456789',
  username: 'johnharris'
  )
image3 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583227479/john_cfzn9a.jpg')
john.photo.attach(io: image3, filename: 'seed')

hilary = User.new(
  email: 'hilary.clinton@gmail.com',
  password: '123456789',
  username: 'therealhilaryclinton'
  )
image3 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583227557/hilary_fxm7fd.jpg')
hilary.photo.attach(io: image3, filename: 'seed')

tristan = User.new(
  email: 'tristan.broski1102@gmail.com',
  password: '123456789',
  username: 'tristanthebro'
  )
image3 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583227580/tristan_nufyzg.jpg')
tristan.photo.attach(io: image3, filename: 'seed')

martha = User.new(
  email: 'marie.stewart@food.com',
  password: '123456789',
  username: 'mmstewart'
  )
image3 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583324950/headshot1_romdxk.jpg')
martha.photo.attach(io: image3, filename: 'seed')

calvin = User.new(
  email: 'calvincohen@gmail.com',
  password: '123456789',
  username: 'ccalvin'
  )
image3 = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583227744/calvin_hnts7d.jpg')
calvin.photo.attach(io: image3, filename: 'seed')



miles.save!
eyal.save!
tamara.save!
david.save!
john.save!
hilary.save!
tristan.save!
martha.save!
calvin.save!

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

protein_ingredients = ['Egg', 'Corn', 'Broccoli', 'Cauliflower', 'Peas', 'Asparagus', 'Salmon', 'Beef', 'Chicken', 'Tuna', 'Pork', 'Turkey', 'Halibut', 'Spelt', 'Teff', 'Black beans', 'Lima beans', 'Chinese cabbage', 'Bison', 'Soya']
grain_ingredients = ['Pasta', 'Wholegrain Bread', 'Wheat flour', 'Red rice', 'Brown rice', 'White rice', 'Potatoes', 'Chickpeas', 'Soybeans', 'Artichoke', 'Potato', 'Parsnips', 'Broccoli', 'Pumpkin', 'Quinoa', 'Almonds', 'Pistachios']
vegetable_ingredients = ['Spinach', 'Bell peppers', 'Kale', 'Alfalfa sprouts', 'Sweet potatoes', 'Broccoli', 'Endive', 'Fennel', 'Basil', 'Thyme', 'Sage', 'Rosemary', 'Parsely', 'Arugula', 'Chives', 'Peas', 'Beets', 'Carrots', 'Tomato', 'Garlic', 'Onion', 'Cauliflower', 'Seaweed']
dairy_ingredients = ['Cream', 'Greek yogurt', 'Cottage cheese', 'Milk', 'Butter', 'Buttermilk', 'Custard', 'Curd', 'Cream cheese', 'Paneer', 'Sour milk']

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
Challenge.build!(tamara, david, accepted: true, expiration: Time.new(2020, 03, 05), mode: 'classic', recipe_id: Recipe.find_by(name: "Simple Pumpkin Soup").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(tamara, miles,  accepted: true, expiration: Time.new(2020, 03, 10), mode: 'classic', recipe_id: Recipe.find_by(name: "Crispy Breaded Cauliflower Wings").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(eyal, david,  accepted: true, expiration: Time.new(2020, 03, 11), mode: 'classic', recipe_id: Recipe.find_by(name: "8-Minute Sweet Potatoes").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(eyal, miles,  accepted: true, expiration: Time.new(2020, 03, 12), mode: 'classic', recipe_id: Recipe.find_by(name: "Sautéed Kale with Lemon, Tahini & Hemp Seeds").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(tamara, eyal, accepted: true, expiration: Time.new(2020, 03, 07), mode: 'creative', protein: Ingredient.find_by(name: 'Salmon'), grain: Ingredient.find_by(name: 'Pistachios'), dairy: Ingredient.find_by(name: 'Milk'), vegetable: Ingredient.find_by(name: 'Broccoli'))
Challenge.build!(miles, eyal, accepted: true, mode: 'creative', protein: Ingredient.find_by(name: 'Asparagus'), grain: Ingredient.find_by(name: 'Parsnips'), dairy: Ingredient.find_by(name: 'Sour milk'), vegetable: Ingredient.find_by(name: 'Endive'))
Challenge.build!(eyal, john,  accepted: true, mode: 'classic', recipe_id: Recipe.find_by(name: "Balsamic Portobello Burgers with Caramelized Onions & Garlic Aioli").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(eyal, tamara,  accepted: true, mode: 'classic', recipe_id: Recipe.find_by(name: "Green Pea Curry Hummus").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(eyal, tristan,  accepted: true, mode: 'classic', recipe_id: Recipe.find_by(name: "Perfect Roasted Potatoes").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))


Challenge.build!(eyal, hilary,  accepted: true, expiration: Time.new(2020, 03, 10), mode: 'creative', protein: Ingredient.find_by(name: 'Beef'), grain: Ingredient.find_by(name: 'Pumpkin'), dairy: Ingredient.find_by(name: 'Curd'), vegetable: Ingredient.find_by(name: 'Alfalfa sprouts'))
Challenge.build!(eyal, john,  accepted: true, expiration: Time.new(2020, 03, 11), mode: 'classic', recipe_id: Recipe.find_by(name: "Crispy Miso Chickpea Bowls with Garlic Sesame Dressing").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))

# these ones are pending
Challenge.build!(eyal, tristan,  accepted: false, expiration: Time.new(2020, 03, 12), mode: 'creative', protein: Ingredient.find_by(name: 'Black beans'), grain: Ingredient.find_by(name: 'Broccoli'), dairy: Ingredient.find_by(name: 'Buttermilk'), vegetable: Ingredient.find_by(name: 'Arugula'))
Challenge.build!(eyal, calvin,  accepted: false, expiration: Time.new(2020, 03, 15), mode: 'classic', recipe_id: Recipe.find_by(name: "1-Pan Mexican Shredded Chicken").id, protein: Ingredient.find_by(name: 'Black beans'), grain: Ingredient.find_by(name: 'Broccoli'), dairy: Ingredient.find_by(name: 'Buttermilk'), vegetable: Ingredient.find_by(name: 'Arugula'))
Challenge.build!(tamara, eyal,  accepted: false, mode: 'classic', recipe_id: Recipe.find_by(name: "Perfect Roasted Potatoes").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(tamara, miles, accepted: false, mode: 'creative', protein: Ingredient.find_by(name: 'Tuna'), grain: Ingredient.find_by(name: 'Almonds'), dairy: Ingredient.find_by(name: 'Butter'), vegetable: Ingredient.find_by(name: 'Kale'))
Challenge.build!(david, tamara, accepted: false, mode: 'classic', recipe_id: Recipe.find_by(name: "Simple Pumpkin Soup").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(miles, tamara, accepted: false, mode: 'creative', protein: Ingredient.find_by(name: 'Tuna'), grain: Ingredient.find_by(name: 'Almonds'), dairy: Ingredient.find_by(name: 'Butter'), vegetable: Ingredient.find_by(name: 'Kale'))


Challenge.build!(martha, eyal,  accepted: false, mode: 'classic', recipe_id: Recipe.find_by(name: "Easy Tofu Pad Thai").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))
Challenge.build!(martha, eyal, accepted: false, mode: 'classic', recipe_id: Recipe.find_by(name: "Grilled Fish Tacos with Pineapple Cabbage Slaw (30 Minutes!)").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'))

puts "generating completed challenges:"
# completed TACO CHALLENGE
c1 = Challenge.build!(miles, eyal, accepted: true, expiration: Time.new(2020, 03, 02), mode: 'classic', recipe_id: Recipe.find_by(name: "Grilled Fish Tacos with Pineapple Cabbage Slaw (30 Minutes!)").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583316882/fishtaco3_gkni5i.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583315713/fishtaco2_f9f0xd.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "You know where your vote is going.", title: "Fish + Taco = YUM")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "Is there anything better than tacos, though? This one was fun to make!", title: "Fish Taco")
print "1, "

# spinach omelette
c2 = Challenge.build!(miles, david, accepted: true, expiration: Time.new(2020, 03, 06), mode: 'creative', protein: Ingredient.find_by(name: 'Egg'), grain: Ingredient.find_by(name: 'Wheat flour'), dairy: Ingredient.find_by(name: 'Butter'), vegetable: Ingredient.find_by(name: 'Parsely'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583325203/egg1_cmy9fz.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583325202/egg2_rnbcnh.png')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "Yes, I didn't use the ingredients, but at least it's delicious!", title: "One Badass Breaky")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "I used all of the ingredients in this dish and borrowed my sister's camera to make it look nice. Please vote for me!", title: "GREATEST OMELETTE")
print "2, "


# chicken bowl
c3 = Challenge.build!(miles, david, accepted: true, expiration: Time.new(2020, 03, 10), mode: 'creative', protein: Ingredient.find_by(name: 'Chicken'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream'), vegetable: Ingredient.find_by(name: 'Corn'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583320702/cbowl1_dgmrsg.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583320701/cbowl2_xpp28j.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "This might be the most Califonian dish I've ever made", title: "Quinoa Bowl w Avocado!!")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "Just barely made this before the time expired", title: "Bowl Shit")
print "3, "

# completed Caramelized Shiitake Mushroom Risotto
c4 = Challenge.build!(calvin, tamara, accepted: true, expiration: Time.new(2020, 03, 02), mode: 'classic', recipe_id: Recipe.find_by(name: "Caramelized Shiitake Mushroom Risotto").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583316047/mrisotto2_ovbp4o.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583316049/mrisotto1_defkov.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "Risotto for the royals. Served this up and my girl couldn't believe how good it was!", title: "Mushroom Risotto")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "This was my first Risotto. I was a little nervous about the outcome but I'm pleasantly surprised. Added a little vino for taste.", title: "Mushroom Riso🍄🍄o")
print "4, "


# 30-Minute Potato Cauliflower Red Lentil Curry
c5 = Challenge.build!(tamara, tristan, accepted: true, expiration: Time.new(2020, 03, 02), mode: 'classic', recipe_id: Recipe.find_by(name: "30-Minute Potato Cauliflower Red Lentil Curry").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583315706/redlentil2_llpyag.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583319281/redlentil3_fwgygv.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "Called my mama up for this one!", title: "Lentilicious")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "All I can say is you WISH you were in my kitchen while I was serving this up 😏", title: "Dank Ass Curry")
print "5, "

# Perfect Roasted Potatoes
c6 = Challenge.build!(miles, david, accepted: true, expiration: Time.new(2020, 03, 03), mode: 'classic', recipe_id: Recipe.find_by(name: "Perfect Roasted Potatoes").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583063746/x0g1koetqaja1ztbujue.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583063727/y5r213vcgfpsa9ksxrxv.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "I could hear these sizzling in the oven, yo. Worth a vote!", title: "Fire Potatoes")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "Tastes like heaven, looks like money.", title: "Better than you mama's")
print "6, "

# BELOW ARE EYAL'S COMPLETED CHALLENGES

# 8-Minute Sweet Potatoes
c7 = Challenge.build!(miles, eyal, accepted: true, expiration: Time.new(2020, 03, 02), mode: 'classic', recipe_id: Recipe.find_by(name: "8-Minute Sweet Potatoes").id, protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583319871/sweetpotato1_skmylg.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583319869/sweetpotato2_dyhlus.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "So simlple, so good.", title: "Sweeeet Potatoes")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "Peeling these was a B word.", title: "Easiest Sweet Potatoes I ever made.")
print "7, "

# sadwich and french toast
c8 = Challenge.build!(david, eyal, accepted: true, expiration: Time.new(2020, 03, 06), mode: 'creative', protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Quinoa'), dairy: Ingredient.find_by(name: 'Cream cheese'), vegetable: Ingredient.find_by(name: 'Spinach'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582803104/vi3nwpxzozuk1zsdwwo1.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1582803097/tfxxbzfqw9tfx7hj4aug.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "Yes, I didn't use the ingredients, but at least it's delicious!", title: "One Badass Breaky")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "I used all of the ingredients in this dish and borrowed my sister's camera to make it look nice. Please vote for me!", title: "GREATEST FRENCH TOAST")
print "8, "

# Pasta
c9 = Challenge.build!(eyal, tamara, accepted: true, expiration: Time.new(2020, 03, 07), mode: 'creative', protein: Ingredient.find_by(name: 'Turkey'), grain: Ingredient.find_by(name: 'Pasta'), dairy: Ingredient.find_by(name: 'Cream'), vegetable: Ingredient.find_by(name: 'Parsely'), voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583324069/pasta1_zwk1jz.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583324069/pasta2_xerwvy.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "I did a one pot dish here and slow cooked it to finish :)", title: "Creamy Penne Chicken Pasta")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "I know my chicken looks like bacon but I swear it's legit 😌", title: "Reconstructed Creamy Chicken Carbonara")
print "9, "

# simple pumpkin soup
c10 = Challenge.build!(eyal, tamara, accepted: true, expiration: Time.new(2020, 03, 12), mode: 'classic', recipe_id: Recipe.find_by(name: "Simple Pumpkin Soup").id, voting_end: Time.now + 6000000)
challenging_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583063746/x0g1koetqaja1ztbujue.jpg')
opposing_dish = open('https://res.cloudinary.com/dtrwqimx6/image/upload/v1583063727/y5r213vcgfpsa9ksxrxv.jpg')
Challenge.all.last.challenger.photo.attach(io: challenging_dish, filename: 'seed')
Challenge.all.last.challenger.update!(caption: "Yes, I didn't use the ingredients, but at least it's delicious!", title: "Pumpernunkle Soup")
Challenge.all.last.opponent.photo.attach(io: opposing_dish, filename: 'seed')
Challenge.all.last.opponent.update!(caption: "First time making pumpkin soup and I'm preeettty pleased with the results.", title: "PUMKIN 🎃")
puts "10!!!"

puts "#{Challenge.count} created"

puts 'Generating votes on challenges'

VOTERS = User.all.reject { |user| user == eyal }
CHALLENGES = [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10]

def generate_votes_on_challenges
  CHALLENGES.each do |challenge|
    VOTERS.each do |voter|
      if (voter != challenge.challenger.user) && (voter != challenge.opponent.user)
        the_player = rand >= 0.5 ? challenge.challenger : challenge.opponent
        Vote.create!(user: voter, player: the_player)
      end
    end
  end
end

generate_votes_on_challenges

puts "Votes generated; you now have #{Vote.count} votes"


