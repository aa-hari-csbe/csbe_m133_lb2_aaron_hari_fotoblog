class AddForeinKeysToCommentAndLike < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :user_id, :integer
    add_column :comments, :picture_id, :integer

    add_column :likes, :user_id, :integer
    add_column :likes, :picture_id, :integer

    add_foreign_key :comments, :users
    add_foreign_key :comments, :pictures

    add_foreign_key :likes, :users
    add_foreign_key :likes, :pictures

  end
end
