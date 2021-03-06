# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!({
               name: "rob",
               email: "rob@gmail.com",
               password: 'password',
               password_confirmation: 'password',
               admin: true,
               activated: true,
               activated_at: Time.zone.now
             })

99.times do |n|
  name = Faker::Name.name
  password = 'password'
  email = "example-#{n+1}@gmail.com"

  puts "seeding user #{n} - #{name}" if n%10 == 0
  User.create!({
                 name: name,
                 email: email,
                 password: password,
                 activated: true,
                 activated_at: Time.zone.now
               })
end