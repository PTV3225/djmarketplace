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
5.times do
  rate = rand(3..5)
  description = "Sample DJ description."
  genre_id = rand(1..5)
  user_id = rand(1..5)
  name = "Sample DJ #{rand(100)}"
  photo_path = random_dj_photo_path

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
    photo: photo_blob, # Using File.open to set the image attachment
    link: 'https://soundcloud.com/sampledjlink'
  )
end

# Create bookings
5.times do
  start_time = Time.now + rand(1..30).days
  end_time = start_time + rand(1..5).hours
  date = start_time.to_date
  dj = Dj.all.sample

  # Calculate total_price based on the rate of the DJ and the duration of the booking
  hours_duration = (end_time - start_time) / 1.hour
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
