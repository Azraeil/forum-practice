class AddDefaultToUserAvatar < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :avatar, :string,default: "https://picsum.photos/300/300/?random"
  end
end
