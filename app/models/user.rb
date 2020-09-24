class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :username
  validates_presence_of :firstname
  validates_presence_of :lastname
end
