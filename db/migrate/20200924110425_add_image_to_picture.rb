class AddImageToPicture < ActiveRecord::Migration[6.0]
  def change
    add_attachment :pictures, :image
  end
end
