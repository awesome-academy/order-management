require "ffaker"

User.create!(name:  "Nguyễn Văn Bảy",
  username: "bayptit",
  password: "111",
  password_confirmation: "111",
  address: "Hà Nội",
  role: 1,
  phone: "0962199791",
  created_at: Time.zone.now)

20.times do |n|
  name  = FFaker::Name.name
  address = FFaker::Address.city
  username = "bay_#{n+1}"
  password = "111"
  phone = FFaker::PhoneNumber.phone_number
  User.create!(name:  name,
  username: username,
  password: "111",
  password_confirmation: "111",
  address: address,
  role: 0,
  phone: phone,
  created_at: Time.zone.now)
end

20.times do |n|
  number = "Bàn số  #{n + 1}"
  description = FFaker::Lorem.sentence(10)
  amount_chair = 2
  Table.create!(number: number,
  description: description,
  amount_chair: amount_chair)
end

20.times do |n|
  name1 = "Combo #{n + 1}"
  status = 1
  price = 100000
  amount_chair = 5
  Combo.create!(name: name1,
  status: status,
  price: price)
end

50.times do |n|
  name = "Product #{n + 1}"
  price = 10000
  image = "a.png"
  status = 1
  Product.create!(name: name,
  price: price,
  image: image,
  status: status)
end
