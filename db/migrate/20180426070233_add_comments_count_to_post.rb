class AddCommentsCountToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :comments_count, :integer
  end

  # 重置 counters
  Post.all.each do |post|
    Post.reset_counters(post.id, :comments)
  end
end
