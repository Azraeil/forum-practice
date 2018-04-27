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
    41.times do |i|

      post = Post.new(
        title: "About " + FFaker::Name::first_name,
        content: FFaker::Lorem::sentence,
        file: "https://picsum.photos/300/300/?random",
        who_can_see: "All",
        status: "publish",
        # for FK category_id
        category_id: Category.all.sample.id,

        # for FK user_id
        user_id: User.all.sample.id
      )

      post.save!
      puts post.title
    end
    puts "Fake posts created!"
  end

  task fake_comment: :environment do
    Comment.destroy_all

    100.times do |i|
      comment = Comment.new(
        content: FFaker::Lorem::sentence,
        user_id: User.all.sample.id,
        post_id: Post.all.first(5).sample.id
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
