class AddColumnProfilpictureToUser < ActiveRecord::Migration[6.0]
  def change
    add_attachment :users, :image
  end
end
