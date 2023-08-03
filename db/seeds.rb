# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def random_dj_photo_path
  photos_folder = Rails.root.join('app', 'assets', 'images', 'sampleDjImages')
  photo_files = Dir.glob("#{photos_folder}/*.{jpg,jpeg}") # Adjust the extensions if needed
  photo_files.sample
end


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

# Create DJ
soundcloud_links = [
  "https://soundcloud.com/the-captain/galactic-funk-instru-mix?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/kid-koala/02-1000-towns-feat-coelacanth?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/djshadow/bbc-6music-segment-4?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/strictly/kaleidoscope-companion-mixed?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
  "https://soundcloud.com/four-tet/kh-essential-mix-2022?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing"
]

melbourne_suburbs = [
  "Richmond",
  "Fitzroy",
  "Brunswick",
  "South Yarra",
  "St Kilda"
]

5.times do |index|
  rate = rand(50..200)
  description = Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false)
  genre_id = Genre.all.sample.id
  user_id = User.all.sample.id
  name = "DJ #{Faker::Name.unique.first_name[0...20]}"
  photo_path = random_dj_photo_path
  soundcloud_link = soundcloud_links[index]
  suburb = melbourne_suburbs[index]

  photo_blob = ActiveStorage::Blob.create_and_upload!(
    io: File.open(photo_path),
    filename: File.basename(photo_path),
    content_type: "image/jpeg"
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

# Create bookings
5.times do
  start_time = DateTime.now + rand(1..30).days
  end_time = start_time + rand(1..5).hours
  if end_time <= start_time
    end_time = start_time + rand(1..5).hours
  end
  date = start_time.to_date
  dj = Dj.all.sample

  # Calculate total_price based on the rate of the DJ and the duration of the booking
  hours_duration = (end_time - start_time).to_f / 1.hour
  # / 1.hour
  total_price = dj.rate * hours_duration

  Booking.create!(
    start_time: start_time,
    end_time: end_time,
    date: date,
    total_price: total_price,
    dj_id: dj.id,
    user_id: User.all.sample.id
  )
end
