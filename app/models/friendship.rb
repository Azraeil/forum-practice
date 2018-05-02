class Friendship < ApplicationRecord
  # 每個好友記錄只能有一組
  validates :friend_id, uniqueness: { scope: :user_id }
  validates :user_id, uniqueness: { scope: :friend_id }

  belongs_to :user
  belongs_to :friend, class_name: "User"
end
