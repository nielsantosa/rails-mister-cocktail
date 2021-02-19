require 'open-uri'
require 'json'

puts "Start seeding 🍑"

puts "Clean up ingredients 🧹"
Ingredient.destroy_all

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
raw_json = open(url).read
json = JSON.parse(raw_json)
json["drinks"].each_with_index do |ingredient, index|
  puts "Create new ingredient 🍒 - #{index + 1}"
  Ingredient.create(name: ingredient["strIngredient1"])
end

puts "Finish seeding 🍑"
