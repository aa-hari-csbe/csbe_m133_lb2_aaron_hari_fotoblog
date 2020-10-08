class User < ApplicationRecord

  # Defines the relationship and dependency to the model comment, and like.
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Defines that the user has a secure(encrypted) password.
  has_secure_password

  validates_presence_of :email
  # Defines that every email must be unique.
  validates_uniqueness_of :email
  validates_presence_of :username
  validates_presence_of :firstname
  validates_presence_of :lastname

  # Defines that this model has a attached image file
  has_attached_file :image
  # Validates the data typ of the column image is a .jpg, .jpeg, or a .gif.
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
