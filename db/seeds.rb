require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')

150.times do
  User.create(
    provider: "Gitbub",
    uid: Faker::Internet.password(8),
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    avatar_url: Faker::Avatar.image
  )
end


100.times do
  Meetup.create(
    name: "#{Faker::Hacker.adjective} #{Faker::Hacker.noun}",
    details: Faker::Lorem.sentence,
    location: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state}",
    creator: User.offset(rand(User.count)).first
  )
end

1000.times do
  Membership.find_or_create_by(
  user_id: Faker::Number.between(1, User.count),
  meetup_id: Faker::Number.between(1, Meetup.count)
  )
end
