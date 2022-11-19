# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
5.times do |i|
  # Creates the user object
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  user = User.create!(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@email.com",
    phone: Faker::PhoneNumber.cell_phone,
    role: 'artist',
    password: 'senha1'
  )

  # Creates the address object
  address = Address.create!(
    zipcode: Faker::Address.zip_code,
    country: Faker::Address.country,
    city: Faker::Address.city,
    street: Faker::Address.street_name,
    number: rand(100..900),
    user: user
  )

  # Creates 5 "post" objects
  5.times do |k|
    url = Faker::LoremFlickr.image(size: "#{rand(200..1000)}x#{rand(200..1000)}", search_terms: ['tattoo'])
    image = URI.open(url)

    post = Post.new(content: Faker::Lorem.paragraph, user: user)
    post.photo.attach(io: image, filename: "image#{0 if i < 10}#{i}.jpg", content_type: "image/jpg")

    post.save!
  end
end
