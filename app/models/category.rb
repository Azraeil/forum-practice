class Category < ApplicationRecord
  # name 欄位必須要填寫
  validates_presence_of :name

  has_many :categories_posts

  # 若發現該 category 底下還有 post 則不能刪除
  has_many :posts, through: :categories_posts, :dependent => :restrict_with_error
end
