class Like < ApplicationRecord

  # Defines the relationship to the model picture, and user.
  belongs_to :picture
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :picture_id
end
