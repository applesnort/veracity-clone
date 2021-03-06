require "open-uri"
# development wipe
if Rails.env.development?
  Cecv.destroy_all
  Message.destroy_all
  ProductOffer.destroy_all
  Product.destroy_all
  Certification.destroy_all
  License.destroy_all
  Offer.destroy_all
  Supplier.destroy_all
  User.destroy_all
end

# variables
file_path = "db/repository/registration.csv"

# users seed
puts "#######################################################################"
puts "Generating test user"
User.create!(
  name: Faker::Name.name,
  email: "test@gmail.com",
  password: "123456",
  country: Faker::Address.country,
  user_type: "purchaser"
)
puts "Test PURChASER account email: #{User.first.email}"

User.create!(
  name: Faker::Name.name,
  email: "faker@gmail.com",
  password: "123456",
  country: Faker::Address.country,
  user_type: "purchaser"
)

cities = ["Beijing", "Chongqing", "Shanghai", "Tianjin", "Anqing", "Bengbu", "Bozhou"]

User.create!(
  name: Faker::Name.name,
  email: "test2@gmail.com",
  password: "123456",
  country: Faker::Address.country,
  user_type: "supplier"
)
puts "Test SUPPLIER account email: #{User.last.email}"
Supplier.first.update!(
  name: "SEKISUI MEDICAL CO., LTD.",
  location: cities.sample,
  industry: "Medical Supplies",
  delivery_terms: ["FOB", "EXW", "FAS", "FCA", "CFR", "CPT", "CIF", "CIP", "DES", "DAF", "DEQ", "DDP", "DDU"].sample,
  payment_terms: ["T/T", "L/C", "D/P", "Western Union", "Moneygram"].sample,
  nearest_port: "Shanghai Port",
  whitelisted: nil,
  fei_number:3006769061,
  established: Date.today - rand(200..10000),
  user: User.last
)

puts "#######################################################################"
Verification.create!(
  veracity_approved: true,
  valid_registration_license: true,
  registration_completion: true,
  supplier: Supplier.first
)


puts "#######################################################################"
2.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6),
    country: "China",
    user_type: :supplier
  )
  puts "#{user.name} created???"

  # Supplier generation
  supplier = Supplier.create!(
    name: Faker::Company.name,
    location: cities.sample,
    industry: "Medical Supplies",
    delivery_terms: ["FOB", "EXW", "FAS", "FCA", "CFR", "CPT", "CIF", "CIP", "DES", "DAF", "DEQ", "DDP", "DDU"].sample,
    payment_terms: ["T/T", "L/C", "D/P", "Western Union", "Moneygram"].sample,
    nearest_port: "#{Faker::Address.city} Puerta",
    whitelisted: nil,
    established: Date.today - rand(200..10000),
    user: user
  )
end

puts "#######################################################################"
puts "Generating licenses???"

Supplier.all.each { |s| License.create!(

    authority: "China Official Government Licensing Agency (COGLA)",
    number: Faker::Alphanumeric.alphanumeric(number: 10),
    start_date: Date.today - 400,
    expired_date: Faker::Date.forward(days: 170),
    supplier: s
)}

puts "#{Supplier.all.count} Suppliers generated."
puts "#######################################################################"
puts "Creating products"

masks = ["Reusable Cotton Face Mask", "Reusable Face Covering", "Disposable 3 Layer Face Mask with Comfortable Earloop"]
thermometers = ["Thermometer for Adults, C/F Switchable", "Non-Contact Infrared Thermometer", "Digital Laser Infrared Thermometer"]
bandages = ["Maximum Hold Waterproof Bandages", "Medical Gauze Stretch Bandage Roll", "Premium Brand Adhesive Bandage Pads"]
# face_shields = ["Reusable Safety Face Shield", "Safety Face Shield Full Protection Cap", "All-Round Protection Hat"]
category = ["Mask","Thermometer","Bandage"]
mask1 = 'https://res.cloudinary.com/demyxeys9/image/upload/v1592529635/veracity/default_photos_seed/mask5_j94k9d.jpg'
mask2 = 'https://res.cloudinary.com/demyxeys9/image/upload/v1592529603/veracity/default_photos_seed/mask4_kvd8ml.jpg'
bandage1 = 'https://res.cloudinary.com/demyxeys9/image/upload/v1592531690/veracity/default_photos_seed/bandage2_elxewc.jpg'
bandage3 = 'https://res.cloudinary.com/demyxeys9/image/upload/v1592531690/veracity/default_photos_seed/bandage5_lxlkc7.png'
bandage2 = 'https://res.cloudinary.com/demyxeys9/image/upload/v1592405102/veracity/default_photos_seed/gtjvkki7552vrgzru1kqs13d57ms.jpg'
thermometer1 = 'https://res.cloudinary.com/demyxeys9/image/upload/v1592405114/veracity/default_photos_seed/cl0r6giograw34m6smvuj5jpkp7s.jpg'
thermometer2 = 'https://res.cloudinary.com/demyxeys9/image/upload/v1592531690/veracity/default_photos_seed/therm4_rc5iye.jpg'
Supplier.all.each do |s|
  mask = [mask1, mask2].sample
  thermometer = [thermometer1, thermometer2].sample
  bandage = [bandage1, bandage2, bandage3].sample
  puts "#" * 50
  p mask
  puts "#" * 50
  m = Product.create!(
    name: masks.sample,
    price: Faker::Commerce.price(range: 2..48.0, as_string: false),
    category: category[0],
    production_quantity: Faker::Number.number(digits: 6),
    minimum_order_quantity: [100,200,300].sample,
    supplier: s,
  )
  m.photos.attach(io: URI.open(mask) , filename: 'mask.png', content_type: 'image/png')
  m.save!

  puts "#" * 50
  p thermometer
  puts "#" * 50
  t = Product.create!(

    name: thermometers.sample,
    price: Faker::Commerce.price(range: 2..48.0, as_string: false),
    category: category[1],
    production_quantity: Faker::Number.number(digits: 6),
    minimum_order_quantity: [100,200,300].sample,
    supplier: s
  )
  t.photos.attach(io: URI.open(thermometer) , filename: 'mask.png', content_type: 'image/png')
  t.save!

  puts "#" * 50
  p bandage
  puts "#" * 50

  b = Product.create!(

    name: bandages.sample,
    price: Faker::Commerce.price(range: 2..48.0, as_string: false),
    category: category[2],
    production_quantity: Faker::Number.number(digits: 6),
    minimum_order_quantity: [100,200,300].sample,
    supplier: s
  )
  b.photos.attach(io: URI.open(bandage) , filename: 'mask.png', content_type: 'image/png')
  b.save!
end

puts "#{Product.all.count} Products generated."

puts "#######################################################################"
puts "Creating certifications"

2.times do
  certification = Certification.create!(
    number: rand(23..5746),
    category: "FDA",
    listing_number: Faker::Number.leading_zero_number(digits: 10),
    code: Faker::Alphanumeric.alphanumeric(number: 5),
    authority: "FDA",
    start_date: Date.today - 200,
    expired_date: Faker::Date.forward(days: 170)
  )
end
puts "#{Certification.count} Certifications created???"

puts "#######################################################################"
puts "Seeding Product Certifications join table"
Product.all.each { |p| p.certifications << Certification.all.sample }
puts "#######################################################################"

puts "#######################################################################"
puts "Seeding messages"
Product.all.each do |p|
  User.where(user_type: :purchaser).each do |u|
    Message.create!(
      product_id: p.id,
      sender_id: u.id,
      receiver_id: p.supplier.user_id,
      title: "Message about #{p.name}",
      content: "Hello #{p.supplier.user.name}, I am #{u.name}"
    )
    Message.create!(
      product_id: p.id,
      sender_id: p.supplier.user_id,
      receiver_id: u.id,
      title: "Reply regarding #{p.name}",
      content: "Thank you for your interest #{u.name}, sincerely???#{p.supplier.user.name}"
    )
  end
end
puts "#######################################################################"

puts "#######################################################################"
# seed the FDA supplier database
puts "Seeding FDA Supplier Database"
Import::FdaRegistration.call(file_path)
puts "#######################################################################"
