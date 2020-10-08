class Picture < ApplicationRecord

  # Defines the relationship and dependency to the model comment, and like.
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Defines that this model has a attached image file
  has_attached_file :image
  # Validates the data typ of the column image is a .jpg, .jpeg, or a .gif.
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
