require 'json'
require 'open-uri'
puts "---- SEEDS SCRIPT STARTING ----"
puts "... Deleting DB"
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all
#create ingredients
puts '... starting SEEDS ...'
puts "... SEEDS : Ingredient -----------"



url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
response = open(url).read
data = JSON.parse(response)
ingredients = data["drinks"]
ingredients.each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end
puts "... SEEDS Ingredient OK"

#create cocktails
puts "... SEEDS : Cocktails -----------"
file1 = URI.open('https://res.cloudinary.com/maelus/image/upload/v1591352730/tco7fjx3narqwnduacnk.jpg')
file2 = URI.open('https://res.cloudinary.com/maelus/image/upload/v1591352725/bd149by2gjchupuo3nqs.jpg')
file3 = URI.open('https://res.cloudinary.com/maelus/image/upload/v1591352715/lfezlxjbort8hq0onxmc.jpg')
cocktail1 = Cocktail.new(name: "Spicy Mateo")
cocktail2 = Cocktail.new(name: "Thomartini")
cocktail3 = Cocktail.new(name: "Adrien Fashion")
cocktail1.image.attach(io: file1, filename: 'cocktail1.jpg', content_type: 'image/jpg')
cocktail2.image.attach(io: file2, filename: 'cocktail2.jpg', content_type: 'image/jpg')
cocktail3.image.attach(io: file3, filename: 'cocktail3.jpg', content_type: 'image/jpg')
cocktail1.save
cocktail2.save
cocktail3.save

puts "... SEEDS Cocktails OK"

#Create doses
puts "... SEEDS : Doses -----------"
cocktails = Cocktail.all
ingredients = Ingredient.all
cocktails.each do |c|
  rand(3..8).times {
    c.doses.create(
      description: "#{rand(1..5)} cl",
      cocktail_id: c.id,
      ingredient_id: ingredients.sample.id
    )
  }
end
puts "... SEEDS Doses OK"
