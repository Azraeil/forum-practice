class Post < ApplicationRecord
  # 刪除文章時一併刪除 文章的分類記錄
  has_many :categories_posts, :dependent => :destroy

  has_many :categories, through: :categories_posts

  belongs_to :user
  has_many :comments, :dependent => :destroy

  has_many :collects, :dependent => :destroy

  def increase_visit
    self.viewed_count += 1
    save!
  end
end
