class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 檢查是否爲網站管理員
  def is_admin?
   if self.role == "Admin"
      return true
   end
  end

  has_many :posts

  has_many :comments

  # 使用者有很多收藏文章的記錄
  has_many :collects

  # 使用者有很多在收藏記錄裡的的文章
  has_many :colleted_posts, through: :collects, source: :post
end
