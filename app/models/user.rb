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
end
