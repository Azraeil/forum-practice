class Post < ApplicationRecord
  has_many :categories_posts, :dependent => :destroy

  has_many :categories, through: :categories_posts, source: :category

  belongs_to :user
  has_many :comments, :dependent => :destroy

  has_many :collects, :dependent => :destroy

  def increase_visit
    self.viewed_count += 1
    save!
  end
end
