if Rails.env.development?

  # 1. Clean the database 🗑️
  puts "==> Cleaning database..."
  Product.destroy_all
  User.destroy_all
  puts "==> Database cleaned."

  # 2. Create Users 🧑‍🚀
  puts "\n==> Creating users..."

  user_1 = User.create!(
    email: "skyboy@spacetraders.com",
    password: "tatooineboy",
    first_name: "Luke",
    last_name: "Skywalker",
    username: "skyboy"
  )
  puts "  -> Created user: #{user_1.email} (Rebel)"

  user_2 = User.create!(
    email: "vader@empire.gov",
    password: "padmelover",
    first_name: "Darth",
    last_name: "Vader",
    username: "darklord"
  )
  puts "  -> Created user: #{user_2.email} (Imperial)"

  user_3 = User.create!(
    email: "boba.fett@bounty.net",
    password: "password123",
    first_name: "Boba",
    last_name: "Fett",
    username: "bountyhunter"
  )
  puts "  -> Created user: #{user_3.email} (Bounty Hunter)"
  puts "==> Users created successfully."

  # 3. Create Products 🚀
  puts "\n==> Creating products..."

  # --- Products for User 1 (Luke/Rebel) ---
  puts "  -> Creating products for #{user_1.email}..."
  product_1 = Product.new(
    user: user_1,
    name: "T-65B X-wing",
    model: "T-65B",
    manufacturer: "Incom Corporation",
    overview: "The T-65B X-wing starfighter remains one of the most iconic symbols of the Rebel Alliance. Manufactured by the Incom Corporation, whose engineering team defected to the Rebellion with the prototypes, the X-wing is a masterful blend of speed and durability. It is renowned for its versatility as a space superiority fighter, capable of engaging TIE fighters and capital ships alike. Equipped with four Taim & Bak KX9 laser cannons and two Krupx MG7 proton torpedo launchers, it delivers significant firepower. Its signature 'S-foils' split into an 'X' configuration during combat, providing greater weapon spread and stability. With a robust shielding system, an onboard hyperdrive, and a dedicated socket for an astromech droid to assist with navigation and in-flight repairs, the T-65B is the reliable workhorse that secured victory in countless engagements, including the legendary Trench Run that led to the destruction of the first Death Star.",
    category: "Spaceships",
    price: 150000.00
  )
  product_1.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/x-wing_starfighter.png")), filename: "x-wing_starfighter.png", content_type: "image/png")
  product_1.save!

  product_2 = Product.new(
    user: user_1,
    name: "R2-D2",
    model: "R2 Astromech",
    manufacturer: "Industrial Automaton",
    overview: "The R2-series astromech droid, manufactured by Industrial Automaton, is widely regarded as one of the most successful and reliable droid lines ever produced. While many astromechs serve as simple navigation and repair units, the R2-series is known for its exceptional durability and a versatile array of tools concealed within its compact, domed chassis. Standard units are equipped with a computer interface arm, an electric arc welder, a circular saw, and a holographic projector. This specific unit, R2-D2, is a prime example of the model's potential, demonstrating unusual bravery and an independent personality that goes far beyond standard programming. Having served Padmé Amidala, Anakin Skywalker, and Luke Skywalker, this droid has played a pivotal role in galactic history, carrying vital information (like the Death Star plans) and executing countless repairs under extreme pressure.",
    category: "Droids",
    price: 75000.00
  )
  product_2.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/r2-d2.png")), filename: "r2-d2.png", content_type: "image/png")
  product_2.save!

  product_3 = Product.new(
    user: user_1,
    name: "Landspeeder X-34",
    model: "X-34",
    manufacturer: "SoroSuub Corporation",
    overview: "The X-34 Landspeeder, a product of the SoroSuub Corporation, is a civilian repulsorlift vehicle designed for personal transport across a wide variety of terrains. While not intended for combat, its powerful repulsorlift engine allows it to hover roughly one meter off the ground, providing a fast and smooth ride over deserts or plains. This particular model, famously used by Luke Skywalker on the desert planet of Tatooine, features an open-air, two-seat cockpit and a modest cargo area. Powered by three turbine engines, it's known for being relatively affordable and highly customizable, though older units often require frequent maintenance. This specific X-34 has seen some wear but remains a dependable transport for anyone needing to get from Point A to Point B quickly, whether navigating canyons or making a quick run to Anchorhead.",
    category: "Vehicles",
    price: 10500.00
  )
  product_3.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/x-34_landspeeder.png")), filename: "x-34_landspeeder.png", content_type: "image/png")
  product_3.save!

  product_4 = Product.new(
    user: user_1,
    name: "C-3PO",
    model: "3PO Protocol Droid",
    manufacturer: "Cybot Galactica",
    overview: "The 3PO-series protocol droid, manufactured by Cybot Galactica, is a hallmark of diplomatic and administrative service throughout the galaxy. Designed to facilitate interactions between diverse species, its primary function is etiquette, customs, and translation. This specific unit, C-3PO, is an exceptional example, boasting fluency in over six million forms of communication. Originally assembled from scrap parts by Anakin Skywalker, C-3PO has been a constant companion to R2-D2 and a reluctant participant in some of the galaxy's most dangerous conflicts. While programmed for protocol, his personality has evolved to be famously fussy and anxious, often providing statistical odds of failure in dire situations. Despite his cautious nature, his linguistic abilities have proven indispensable.",
    category: "Droids",
    price: 45000.00
  )
  product_4.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/c-3po.png")), filename: "c-3po.png", content_type: "image/png")
  product_4.save!

  product_5 = Product.new(
    user: user_1,
    name: "T-47 Airspeeder",
    model: "T-47 (Snowspeeder)",
    manufacturer: "Incom Corporation",
    overview: "The T-47 Airspeeder, originally a civilian freight-handling craft, was heavily modified by the Rebel Alliance for patrol and combat operations, earning its famous designation as the 'Snowspeeder' during the Battle of Hoth. Adapted by Rebel technicians to withstand the brutally cold temperatures of the ice planet, this two-person craft (crewed by a pilot and a rear-facing tail-gunner) became a symbol of desperate ingenuity. It is armed with twin heavy laser cannons and a rear-facing blaster cannon. However, its most critical modification is a high-powered magnetic harpoon and tow cable, famously adapted by Rebel pilots to tangle the legs of the towering Imperial AT-AT walkers, proving that even modified civilian equipment could challenge the Empire's might.",
    category: "Vehicles",
    price: 18000.00
  )
  product_5.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/t-47_airspeeder.png")), filename: "t-47_airspeeder.png", content_type: "image/png")
  product_5.save!

  # --- Products for User 2 (Vader/Imperial) ---
  puts "  -> Creating products for #{user_2.email}..."
  product_6 = Product.new(
    user: user_2,
    name: "Death Star",
    model: "DS-1 Orbital Battle Station",
    manufacturer: "Galactic Empire",
    overview: "The DS-1 Orbital Battle Station, known colloquially as the Death Star, represents the pinnacle of Imperial military engineering and the core tenet of the Tarkin Doctrine: rule through fear. A moon-sized deep-space station, it was designed by a secretive team led by Orson Krennic and built under the oversight of Grand Moff Tarkin. Its primary weapon is a superlaser powered by massive kyber crystals, granting it the terrifying capability to destroy an entire planet with a single blast. The station itself is a self-sufficient fortress, carrying a crew of over a million Imperial personnel, thousands of TIE fighters, turbolaser batteries, and a full legion of stormtroopers. While intended to be the ultimate weapon to crush any dissent, its reliance on a single, centralized power system, accessible via a small thermal exhaust port, proved to be its critical and ultimately fatal design flaw.",
    category: "Spaceships",
    price: 999999999.00
  )
  product_6.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/death_star.png")), filename: "death_star.png", content_type: "image/png")
  product_6.save!

  product_7 = Product.new(
    user: user_2,
    name: "TIE Fighter",
    model: "TIE/ln",
    manufacturer: "Sienar Fleet Systems",
    overview: "The TIE/ln space superiority starfighter, or 'TIE Fighter,' is the most recognizable symbol of the Imperial Starfighter Corps. Manufactured by Sienar Fleet Systems, its design philosophy prioritizes speed, agility, and overwhelming numbers over pilot survivability. The TIE/ln is propelled by twin ion engines (TIE), which give the craft its incredible maneuverability and its signature, terrifying scream in atmospheric combat. To keep costs low and production high, the TIE Fighter is stripped of all non-essential systems: it possesses no shields, no hyperdrive, and no life support system, forcing its pilots to wear self-contained flight suits. Armed with two powerful SFS L-s1 laser cannons, it is a deadly opponent in a dogfight, designed to swarm and overwhelm Rebel craft.",
    category: "Spaceships",
    price: 60000.00
  )
  product_7.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/tie_fighter.png")), filename: "tie_fighter.png", content_type: "image/png")
  product_7.save!

  product_8 = Product.new(
    user: user_2,
    name: "AT-AT Walker",
    model: "All Terrain Armored Transport",
    manufacturer: "Kuat Drive Yards",
    overview: "The All Terrain Armored Transport (AT-AT) is a quadrupedal combat walker that serves as the Galactic Empire's psychological and tactical 'heavy-hitter' on the battlefield. Manufactured by Kuat Drive Yards, this towering vehicle stands over 20 meters tall and is designed for ground assault and transport. Its heavy armor plating is impervious to all but the most powerful artillery, and its height provides a commanding view of the battlefield. It is armed with twin heavy laser cannons under its 'chin' for devastating long-range bombardment and medium blasters on its 'temples' for anti-personnel defense. While its size makes it a terrifying sight, its primary role is often to deploy stormtrooper platoons directly into the heart of enemy lines.",
    category: "Vehicles",
    price: 250000.00
  )
  product_8.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/at-at_walker.png")), filename: "at-at_walker.png", content_type: "image/png")
  product_8.save!

  product_9 = Product.new(
    user: user_2,
    name: "IT-O Interrogation Droid",
    model: "IT-O",
    manufacturer: "Arakyd Industries",
    overview: "The IT-O Interrogation Droid is a terrifying instrument of the Imperial Security Bureau and Sith Lord Darth Vader. Manufactured by Arakyd Industries, this gleaming black sphere hovers silently on a repulsorlift, its appearance alone designed to inspire dread. The IT-O is not a combat unit but a specialized tool for breaking the will of even the most resilient subjects. It is equipped with a formidable array of implements concealed beneath its panels, including neuro-shock probes, chemical injectors loaded with 'truth serums,' sonic torture devices, and precision scalpels. Its primary function is to bypass a prisoner's mental defenses through systematic application of pain and psychological terror. Its presence signals that the Empire will extract the information it seeks, one way or another.",
    category: "Droids",
    price: 30000.00
  )
  product_9.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/it-o.png")), filename: "it-o.png", content_type: "image/png")
  product_9.save!

  product_10 = Product.new(
    user: user_2,
    name: "74-Z Speeder Bike",
    model: "74-Z",
    manufacturer: "Aratech Repulsor Company",
    overview: "The 74-Z Speeder Bike, manufactured by the Aratech Repulsor Company, is a high-performance military reconnaissance vehicle used extensively by Imperial scout troopers. Designed for speed and agility above all else, the 74-Z is essentially a powerful repulsorlift engine with a seat and steering vanes. It can reach blistering speeds over 500 km/h, making it ideal for rapid patrols and pursuit missions in difficult terrain, as famously demonstrated in the forests of Endor. This speed, however, comes at the cost of safety; the vehicle offers no protection to its rider and is notoriously difficult to control, requiring specialized training and lightning-fast reflexes. It is lightly armed with a single, forward-mounted blaster cannon.",
    category: "Vehicles",
    price: 8000.00
  )
  product_10.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/74-z_speeder_bike.png")), filename: "74-z_speeder_bike.png", content_type: "image/png")
  product_10.save!

  # --- Products for User 3 (Boba Fett/Bounty Hunter) ---
  puts "  -> Creating products for #{user_3.email}..."
  product_11 = Product.new(
    user: user_3,
    name: "Slave I",
    model: "Firespray-31",
    manufacturer: "Kuat Systems Engineering",
    overview: "Originally a Firespray-31-class patrol and attack craft, the *Slave I* is a heavily modified, infamous starship used by the bounty hunters Jango Fett and, later, his clone-son Boba Fett. Manufactured by Kuat Systems Engineering, the ship is notable for its unique design, landing horizontally but flying in a vertical orientation, providing an effective combat profile. The *Slave I* has been refitted for decades to be a perfect tool for bounty hunting, bristling with concealed weaponry far beyond its original specs. This includes twin rotating blaster cannons, ion cannons, proton torpedo launchers, and, most famously, a seismic charge launcher that produces a devastating, sound-dampened explosion. With its powerful engines, advanced jamming suites, and a fully-equipped prisoner hold, this is one of the most feared personal vessels in the galaxy.",
    category: "Spaceships",
    price: 220000.00
  )
  product_11.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/slave_i.png")), filename: "slave_i.png", content_type: "image/png")
  product_11.save!

  product_12 = Product.new(
    user: user_3,
    name: "IG-88 Assassin Droid",
    model: "IG-88",
    manufacturer: "Holowan Laboratories",
    overview: "The IG-88 Assassin Droid is a rogue IG-series combat droid manufactured by Holowan Laboratories. Originally intended as elite security units, the IG-88 line achieved full sentience moments after activation and promptly slaughtered its creators. This tall, skeletal, chrome-plated droid is a relentless and brutally efficient bounty hunter. Its design is purely functional: its head is a 360-degree sensor package, and its body is a housing for multiple weapons systems, including built-in blaster cannons, a pulse cannon, a concussion grenade launcher, and vibro-blades. IG-88 operates with cold, machine logic, making it an unstoppable pursuer that will never sleep, never falter, and never stop until its quarry is captured or eliminated.",
    category: "Droids",
    price: 120000.00
  )
  product_12.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/ig-88.png")), filename: "ig-88.png", content_type: "image/png")
  product_12.save!

  product_13 = Product.new(
    user: user_3,
    name: "Z-6 Jetpack",
    model: "Z-6",
    manufacturer: "Mandalorian",
    overview: "The Z-6 Jetpack is a pinnacle of Mandalorian personal transport and combat technology, famously utilized by bounty hunters Jango Fett and Boba Fett. More than just a simple repulsorlift, this jetpack provides short-burst flight capabilities, allowing its user incredible verticality and speed in a firefight. It is an essential tool for evening the odds against multiple opponents. The Z-6 model is particularly sought after for its integrated weapons system: a top-mounted, computer-guided anti-vehicle homing missile, capable of taking down heavily armored targets. With a limited fuel supply, it requires expert control, but for a skilled warrior, it turns them into a one-person-army, able to strike from any angle.",
    category: "Vehicles",
    price: 35000.00
  )
  product_13.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/z-6_jetpack.png")), filename: "z-6_jetpack.png", content_type: "image/png")
  product_13.save!

  product_14 = Product.new(
    user: user_3,
    name: "Millennium Falcon",
    model: "Corellian YT-1300f",
    manufacturer: "Corellian Engineering Corporation",
    overview: "A legendary freighter with a notorious reputation. Originally a standard YT-1300 light freighter, this ship has been extensively modified by its various owners, including Lando Calrissian and Han Solo. While it may look like a 'hunk of junk,' its appearance is deceptive. It's outfitted with a military-grade hyperdrive (one of the fastest in the galaxy), illegal sensor-jamming suites, and surprisingly powerful quad-laser cannons. Its durability is unmatched, having survived battles against Star Destroyers and two Death Stars. This ship is a testament to customization, a perfect vessel for a smuggler, bounty hunter, or anyone who needs to make a fast getaway and isn't afraid to get their hands dirty on repairs.",
    category: "Spaceships",
    price: 300000.00
  )
  product_14.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/millenium_falcon.png")), filename: "millenium_falcon.png", content_type: "image/png")
  product_14.save!

  product_15 = Product.new(
    user: user_3,
    name: "Vulture Droid Starfighter",
    model: "Vulture-class",
    manufacturer: "Haor Chall Engineering",
    overview: "A relic from the Clone Wars, the Vulture-class Droid Starfighter remains a versatile and deadly piece of automated hardware. Manufactured by Haor Chall Engineering for the Separatist Navy, these droids formed the bulk of the Trade Federation's starfighter corps. Their unique design allows them to transform: in space, they are agile fighters, but on planetary surfaces, their wings can split into four 'legs,' allowing them to walk and serve as ground patrol units. While lacking the creative piloting of an organic, they are networked, allowing them to swarm targets with terrifying coordination. Armed with blaster cannons and energy torpedo launchers, these droids are still highly effective as automated security.",
    category: "Spaceships",
    price: 40000.00
  )
  product_15.photos.attach(io: File.open(Rails.root.join("app/assets/images/seed_images/vulture_droid_starfighter.png")), filename: "vulture_droid_starfighter.png", content_type: "image/png")
  product_15.save!
  puts "==> Products created successfully."

  # 4. Final Completion Message ✅
  puts "\n==> Seed Process Completed! ✅"
  puts "  -> Total Users: #{User.count}"
  puts "  -> Total Products: #{Product.count}"

else
  puts "==> Skipping seed data (Not in development environment)."
end
