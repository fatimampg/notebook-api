namespace :test_db do
  desc "Config test database"
  task setup: :environment do
    puts "Reset test database"

    test_db_path = "storage/test.sqlite3"
    File.delete(test_db_path) if File.exist?(test_db_path)
    system("RAILS_ENV=test rails db:create")
    # %x(RAILS_ENV=test rails db:create)
    system("RAILS_ENV=test rails db:schema:load")
    # %x(RAILS_ENV=test rails db:schema:load)

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

    puts "Creating addresses for registered contacts..."
    Contact.all.each do |contact|
        Address.create!(street: Faker::Address.street_address, city: Faker::Address.city, contact: contact)
    end
    puts "Addresses added to contacts"
  end
end
