namespace :dev do
  task fake_user: :environment do
    # User.destroy_all
    20.times do |i|
      # file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: FFaker::Name::first_name,
        email: FFaker::Internet.email,
        password: "12345678",
        introduction: FFaker::Lorem::sentence(3),
        avatar: "https://picsum.photos/300/300/?random"
      )

      user.save!
      puts user.name
    end
    puts "Fake users created!"
  end
end
