# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# 1. Create new user
user_1 = User.create!(
  email: "skyboy3@tatooine.com",
  password: "padmelover"

  )
  puts user_1.email

# 1. Clean the database 🗑️
puts "Cleaning database..."
Product.destroy_all

# 2. Create the instances 🏗️
product_1 = Product.new(
  user: user_1,
  name: "Death Star",
  model: "DS-1 Orbital Battle Station",
  manufacturer: "Imperial Department of Military Research, Sienar Fleet Systems",
  overview: "The Death Star, also known as Death Star I, First Death Star, Platform DS-1, and initially Ultimate Weapon in its early stages of development, was a moon-sized deep-space mobile battle station built by the Galactic Empire.",
  price: 10000000.00
)
product_1.photos.attach(
  io: URI.open("https://static.wikia.nocookie.net/ptstarwars/images/8/80/Estrela_da_Morte.jpg/revision/latest?cb=20131116033038"),
  filename: "death_star.jpg",
  content_type: "image/jpg"
)
product_1.save!

product_2 = Product.new(
  user: user_1,
  name: "R2-D2",
  model: "R2-series astromech droid",
  manufacturer: "Automaton Industries",
  overview: "R2-D2, also known simply as R2, was an R2-series astromech droid produced by Automaton Industries with male programming.",
  price: 17000.00
)
product_2.photos.attach(
  io: URI.open("https://static.wikia.nocookie.net/ptstarwars/images/1/1a/R2d2.jpg/revision/latest?cb=20060701231820"),
  filename: "r2d2.jpg",
  content_type: "image/jpg"
)
product_2.save!

product_3 = Product.new(
  user: user_1,
  name: "AT-AT Walker",
  model: "All Terrain Armored Transport",
  manufacturer: "Kuat Drive Yards",
  overview: "The All Terrain Armored Transport (Prototype), or AT-AT/P, was the original model of combat walker transport used by the Imperial Army of the Galactic Empire throughout the Imperial Era. It was one of several different models produced by Kuat Drive Yards prior to the release of the standard All Terrain Armored Transport.",
  price: 50000.00
)
product_3.photos.attach(
  io: URI.open("https://static.wikia.nocookie.net/starwars/images/1/11/AT-AT_Rebels_Fathead.png/revision/latest/scale-to-width-down/1000?cb=20161108043916"),
  filename: "atat_walker.jpg",
  content_type: "image/jpg"
)
product_3.save!

product_4 = Product.new(
  user: user_1,
  name: "T-65B X-wing starfighter",
  model: "T-65B space superiority fighter",
  manufacturer: "Incom Corporation",
  overview: "The T-65B X-wing starfighter, also known as the T-65B space superiority fighter,[3] or T-65B X-wing multi-role starfighter,[27] was a single-seat craft manufactured by Incom Corporation and used most famously by the Alliance to Restore the Republic during the Galactic Civil War. Renowned for its speed and maneuverability in battle, it became the backbone of the Rebel Alliance Starfighter Corps, being both harder hitting and tougher under fire than its main adversary, the mass-produced TIE/ln space superiority starfighter. Years after the Galactic Civil War, newer X-wing models, such as the T-70 X-wing starfighter, and the T-85 X-wing would come to replace the model.",
  price: 70000.00
)
product_4.photos.attach(
  io: URI.open("https://static.wikia.nocookie.net/starwars/images/6/60/Xwing-SWB.jpg/revision/latest/scale-to-width-down/1000?cb=20160704070524"),
  filename: "t65b_starfighter.jpg",
  content_type: "image/jpg"
)
product_4.save!


# 3. Display a message 🎉
puts "Finished! Created #{Product.count} products."
puts "Finished! Created #{User.count} users."
