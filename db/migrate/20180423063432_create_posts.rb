class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title,   null: false
      t.string :content, null: false
      t.string :who_can_see, null: false
      t.string :status
      t.string :file

      t.timestamps
    end
  end
end
