namespace :dev do
  desc "Config dev environment"
  task setup: :environment do
    puts "Reset database"
    %x(rails db:drop db:create db:migrate)

    puts "Creating kind of contacts"
    kinds = [ "Friend", "Commercial", "Known" ]
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Kind of contacts successfully created"

    puts "Creating fake contacts..."
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end
    puts "Contacts successfully created"

    puts "Creating fake phone numbers..."
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        Phone.create!(number: Faker::PhoneNumber.cell_phone, contact: contact)
      end
    end
    puts "Phone numbers successfully created"

    puts "Creating addresses for regitered contacts..."
    Contact.all.each do |contact|
        Address.create!(street: Faker::Address.street_address, city: Faker::Address.city, contact: contact)
    end
    puts "Addresses added to contacts"
  end
end
