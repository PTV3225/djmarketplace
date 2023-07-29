# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


#users
5.times do |i|
  first_name = "User#{i + 1}"
  last_name = "Lastname#{i + 1}"
  email = "user#{i + 1}@example.com"
  password = "password#{i + 1}"
  User.create!({
   first_name: first_name,
   last_name: last_name,
   email: email,
   password: password
  })

  end


 #adminlogin
 User.create!({
  first_name: "Admin",
  last_name: "User",
  email: "admin@example.com",
  password: "123456"
 })





# Create genres
genres = [
  "House",
  "Techno",
  "Electronic",
  "Hip-hop",
  "Trance",
  "Drum and Bass",
  "Dubstep",
  "Tech House",
  "Deep House",
  "Progressive House",
  "Disco",
  "Funk",
  "Soul",
  "Trap",
  "R&B",
  "Reggae",
  "Dancehall",
  "Salsa",
  "Bachata",
  "Merengue",
  "Cumbia",
  "Reggaeton",
  "Moombahton",
  "Latin",
  "Afrobeat",
  "Kizomba",
  "Soca",
  "Bollywood",
  "Bhangra",
  "Jazz",
  "Funk",
  "Soul",
  "Pop",
  "Rock",
  "Indie",
  "Alternative",
  "Metal",
  "Punk",
  "Classical",
  "Blues",
  "Ambient",
  "Chillout",
  "Lounge",
  "Nu-Disco",
  "Electro",
  "Hardstyle",
  "Tropical House",
  "Melodic Techno",
  "Tech Trance",
  "Psytrance",
  "Hardcore",
  "Eurodance",
  "Future Bass"
]

genres.each do |category|
  Genre.create!(category: category)
end




#Create DJ
5.times do
  rate = rand(3..5)
  description = "Sample DJ description."
  genre_id = rand(1..5)
  user_id = rand(1..5)
  name = "Sample DJ #{rand(100)}"
  photo = "sample_photo.jpg"

  Dj.create!(
  rate: rate,
  description: description,
  genre_id: genre_id,
  user_id: user_id,
  name: name,
  photo: photo
  )
  end

  # Create bookings
  5.times do
  start_date = Date.today + rand(1..30).days
  end_date = start_date + rand(1..5).days
  total_price = rand(50.0..300.0)
  dj_id = rand(1..5)
  user_id = rand(1..5)

  Booking.create!(
  start_date: start_date,
  end_date: end_date,
  total_price: total_price,
  dj_id: dj_id,
  user_id: user_id
  )
end
