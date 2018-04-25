class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string  :name, null: false
      t.timestamps
    end

    # 在 posts table 增加 FK，在多的那邊增加少的 model FK。
    add_column :posts, :category_id, :integer
  end
end
