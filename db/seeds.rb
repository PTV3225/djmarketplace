# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "clearing database"

Booking.destroy_all
Dj.destroy_all
Genre.destroy_all
User.destroy_all

puts "creating database"

def random_dj_photo_path
  photos_folder = Rails.root.join('app', 'assets', 'images', 'sampleDjImages')
  photo_files = Dir.glob("#{photos_folder}/*.{jpg,jpeg}") # Adjust the extensions if needed
  photo_files.sample
end


#users
50.times do |i|
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

# Create DJ
soundcloud_links = [
  "https://soundcloud.com/the-captain/galactic-funk-instru-mix?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/kid-koala/02-1000-towns-feat-coelacanth?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/djshadow/bbc-6music-segment-4?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/strictly/kaleidoscope-companion-mixed?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/four-tet/kh-essential-mix-2022?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/ninja-tune/sets/vtss-make-you-scream-dixon?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/p_t_v/ptv-live-dj-mix-clarendon-st?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/diplo/sets/diplo-deluxe-extended?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing"
]

melbourne_suburbs = [
  "Richmond",
  "Fitzroy",
  "Brunswick",
  "South Yarra",
  "St Kilda",
  "Ivanhoe",
  "Camberwell",
  "Newport",
  "Bentleigh",
  "Glen Iris",
  "Balwyn",
  "Box Hill",
  "Preston",
  "Reservoir",
  "Oakleigh",
  "Fitzroy North",
  "Surrey Hills",
  "Maribyrnong",
  "Altona",
  "Southbank",
  "Coburg North",
  "Fairfield",
  "Clifton Hill",
  "Pascoe Vale",
  "Kensington",
  "West Footscray",
  "Hawthorn",
  "Coburg",
  "North Melbourne",
  "Essendon",
  "Kew",
  "Thornbury",
  "Malvern",
  "Moonee Ponds",
  "Ascot Vale",
  "Williamstown",
  "Yarraville",
  "Preston",
  "Reservoir",
  "Oakleigh",
  "Fitzroy North",
  "Surrey Hills",
  "Maribyrnong",
  "Altona",
  "Southbank",
  "Coburg North",
  "Fairfield",
  "Clifton Hill",
  "Pascoe Vale",
  "Kensington",
  "West Footscray"
]

50.times do |index|
  rate = rand(50..500)
  description = Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false)
  genre_id = Genre.all.sample.id
  user_id = User.all.sample.id
  name = "DJ #{Faker::Name.unique.first_name[0...20]}"
  photo_path = random_dj_photo_path
  soundcloud_link = soundcloud_links.sample
  suburb = melbourne_suburbs.sample

  photo_blob = ActiveStorage::Blob.create_and_upload!(
    io: File.open(photo_path),
    filename: File.basename(photo_path),
    content_type: "image/jpg"
  )

  Dj.create!(
    rate: rate,
    description: description,
    genre_id: genre_id,
    user_id: user_id,
    name: name,
    photo: photo_blob,
    link: soundcloud_link,
    location: suburb
  )
end

# # Create bookings
# 25.times do
#   start_time = DateTime.now + rand(1..30).days
#   end_time = start_time + rand(1..5).hours
#   if end_time <= start_time
#     end_time = start_time + rand(1..5).hours
#   end
#   date = start_time.to_date
#   dj = Dj.all.sample

#   # Calculate total_price based on the rate of the DJ and the duration of the booking
#   hours_duration = (end_time.to_time - start_time.to_time)/ 1.hours
#   # / 1.hour



#   total_price = dj.rate * hours_duration

#   Booking.create!(
#     start_time: start_time,
#     end_time: end_time,
#     date: date,
#     total_price: total_price,
#     dj_id: dj.id,
#     user_id: User.all.sample.id
#   )
# end
