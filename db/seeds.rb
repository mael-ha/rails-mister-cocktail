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
Cocktail.create(name: "Spicy Mateo", image: "bd149by2gjchupuo3nqs")
Cocktail.create(name: "Thomartini", image: "lfezlxjbort8hq0onxmc")
Cocktail.create(name: "Adrien Fashion", image: "tco7fjx3narqwnduacnk")
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
