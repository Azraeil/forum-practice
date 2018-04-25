# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create two admin users
admin = User.new(
  name: "Administrator",
  email: "admin@test.com",
  password: "123123",
  introduction: FFaker::Lorem::sentence(3),
  avatar: "https://picsum.photos/300/300/?random",
  role: "Admin"
)

admin.save!

admin = User.new(
  name: "Admin",
  email: "admin@example.com",
  password: "12345678",
  introduction: FFaker::Lorem::sentence(3),
  avatar: "https://picsum.photos/300/300/?random",
  role: "Admin"
)

admin.save!

puts "admin account created!"

# Create Category
Category.destroy_all

category_list = [
  { name: "Category1" },
  { name: "Category2" },
  { name: "Category3" },
  { name: "Category4" },
  { name: "Category5" }
]

category_list.each do |c|
  Category.create(name: c[:name])
end

puts "Default category seed data created!"
