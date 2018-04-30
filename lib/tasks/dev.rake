namespace :dev do
  task fake_user: :environment do
    # User.destroy_all
    20.times do |i|
      # file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: FFaker::Name::first_name,
        email: FFaker::Internet.email,
        password: "12345678",
        introduction: FFaker::Lorem::sentence(10),
        avatar: "https://picsum.photos/300/300/?random"
      )

      user.save!
      puts user.name
    end
    puts "Fake users created!"
  end

  task fake_post: :environment do
    Post.destroy_all
    50.times do |i|

      post = Post.new(
        title: FFaker::Lorem::sentence(1),
        content: FFaker::Lorem::sentence(15),
        file: "https://picsum.photos/300/300/?random",
        who_can_see: "All",
        status: "publish",
        # for FK category_id
        category_ids: Category.all.sample.id,

        # for FK user_id
        user_id: User.all.sample.id,

        viewed_count: rand(1..50)
      )

      post.save!
      puts post.title
    end
    puts "Fake posts created!"
  end

  task fake_comment: :environment do
    Comment.destroy_all

    800.times do |i|
      comment = Comment.new(
        content: FFaker::Lorem::sentence(15),
        user_id: User.all.sample.id,
        post_id: Post.all.order(id: :desc).first(40).sample.id
      )
      comment.save!
      puts comment.content
    end

    puts "Fake comments created!"
  end

  task fake_collect: :environment do
    Collect.destroy_all

    100.times do |i|
      collect = Collect.new(
        user_id: User.all.sample.id,
        post_id: Post.all.first(10).sample.id
      )
      collect.save
      puts collect
    end

    puts "Fake collects created!!"
  end

end
