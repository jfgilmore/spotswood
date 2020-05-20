# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Interaction.destroy_all
Listing.destroy_all
User.destroy_all

def image_fetcher
  URI.open(Faker::Avatar.image(slug: "my-own-slug", size: "300x300", format: "jpg"))
  rescue
  URI.open("https://robohash.org/sitsequiquia.png?size=300x300&set=set1")
end

def avatar_attach user
  user.avatar.attach({
    io: image_fetcher,
    filename: "#{user.name}_faker_image.jpg"
  })
end

def make_listing(user)
  user = user
  puts 'Creating listings'
  5.times do
    lstng = user.listings.new(
      name: Faker::Hacker.adjective,
      time: Faker::Time.forward(days: 10, period: :afternoon),
      location: Faker::Address.full_address,
      why: Faker::Lorem.sentence,
      cost: rand(100),
      summary: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph_by_chars,
      updated_at: DateTime.current
    )
    lstng.save ? print('.') : ''
  end
end

def make_interaction(user)
  puts 'Creating interactions'
  5.times do
    user.interactions.new(
    listing_id: rand(user.id),
    user_action: rand(3)
    ).save ? print('.') : ''
  end
end

# Test admin
admin = User.create(
  name: Faker::Name.middle_name,
  email: 'admin@test.com',
  password: 'aaaaaa',
  role: :admin,
  coc: true
)
avatar_attach admin
puts 'Admin user created'
make_listing admin

# Test moderator
mod = User.create(
  name: Faker::Name.middle_name,
  email: 'mod@test.com',
  password: 'aaaaaa',
  role: :moderator,
  coc: true
)
avatar_attach mod
puts 'Moderator user created'
make_listing mod

# Test users
10.times do
  user = User.create(
    name: Faker::Name.middle_name,
    email: Faker::Internet.email,
    password: '123456',
    role: :user,
    coc: true
  )
  avatar_attach user
  puts 'Standard user created'
  make_listing user
  make_interaction user
end
