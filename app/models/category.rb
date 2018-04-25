class Category < ApplicationRecord
  # name 欄位必須要填寫
  validates_presence_of :name

  has_many :posts
end
