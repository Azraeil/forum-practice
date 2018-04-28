class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_authentication_token

  has_many :posts

  has_many :comments

  # 使用者有很多收藏文章的記錄
  has_many :collects

  # 使用者有很多在收藏記錄裡的的文章
  has_many :collected_posts, through: :collects, source: :post

  # 檢查是否爲網站管理員
  def is_admin?
   if self.role == "Admin"
      return true
   end
  end

  def is_collected?(post)
    self.collected_posts.include?(post)
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end
end
