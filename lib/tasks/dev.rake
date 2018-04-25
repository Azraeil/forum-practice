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

  task fake_post: :environment do
    Post.destroy_all
    10.times do |i|

      post = Post.new(
        title: "About " + FFaker::Name::first_name,
        content: FFaker::Lorem::sentence(6),
        who_can_see: "All",
        # for FK category_id
        category: Category.all.sample
      )

      post.save!
      puts post.title
    end
    puts "Fake posts created!"
  end

end
