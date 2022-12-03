# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def random_boolean
  [true, false].sample
end

5.times do |i|
  # Creates the user object
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  user = User.create!(
    first_name:,
    last_name:,
    email: "#{first_name.downcase}.#{last_name.downcase}@email.com",
    phone: Faker::PhoneNumber.cell_phone,
    role: 'artist',
    password: 'senha1'
  )

  puts "created user #{user}"

  # Creates the address object
  Address.create!(
    zipcode: Faker::Address.zip_code,
    country: Faker::Address.country,
    city: Faker::Address.city,
    street: Faker::Address.street_name,
    number: rand(100..900),
    user:
  )

  puts "created address #{user.address} for user #{user}"

  # Creates 5 "post" objects
  5.times do
    url = Faker::LoremFlickr.image(size: "#{rand(200..800)}x#{rand(200..800)}", search_terms: ['tattoo'])
    image = URI.open(url)

    post = Post.new(content: Faker::Lorem.paragraph, user:)
    post.photo.attach(io: image, filename: "image#{0 if i < 10}#{i}.jpg", content_type: "image/jpg")

    post.tag_list = Tag::TAG.sample

    post.save!

    puts "created post #{post} with tag #{post.tag_list}"
  end

  puts ""
end

User.all.each do |user|
  # Retrieves a random number according to the total amount of posts
  Post.all.each do |post|
    if random_boolean()
      like = Like.create!(
        post:,
        user:
      )
      puts "user #{like.user} liked post #{like.post}"
    end
  end

  Post.all.each do |post|
    if random_boolean()
      comment = Comment.create!(
        content: Faker::Lorem.paragraph,
        post:,
        user:
      )
      puts "user #{comment.user} commented \"#{comment.content}\"on post #{comment.post}"
    end
  end
end
