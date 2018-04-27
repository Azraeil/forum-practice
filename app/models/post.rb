class Post < ApplicationRecord
  belongs_to :category

  belongs_to :user
  has_many :comments, :dependent => :destroy

  has_many :collects, :dependent => :destroy
end
