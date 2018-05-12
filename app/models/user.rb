class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_authentication_token

  # 讓 name 爲必填欄位
  validates_presence_of :name

  # 加上驗證 name 不能重覆
  validates_uniqueness_of :name

  # 刪除使用者時，一併將該使用者的文章刪除
  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  # 使用者有很多收藏文章的記錄
  has_many :collects, dependent: :destroy

  # 使用者有很多在收藏記錄裡的的文章
  has_many :collected_posts, through: :collects, source: :post

  # 好友與好友關係
  has_many :friendships, dependent: :destroy

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

  def friend?(user)
    # 判斷兩方是否有好友邀請記錄
    friendship_record = Friendship.where(user_id: user.id, friend_id: self.id).or(Friendship.where(user_id: self.id, friend_id: user.id))
    if friendship_record.any?
      # 有好友記錄
      if friendship_record.first.status == "accept"
        return "friend"
      else
        return "exist"
      end
    else
      # 沒有好友記錄
      return "none"
    end
  end
end
