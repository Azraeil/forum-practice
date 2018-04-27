class Collect < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 使用者不能收藏同一個的文章
  validates :post_id, uniqueness: { scope: :user_id }
end
