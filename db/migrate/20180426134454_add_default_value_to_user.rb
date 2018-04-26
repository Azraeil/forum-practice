class AddDefaultValueToUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :comments_count, :integer, default: 0
  end
end
