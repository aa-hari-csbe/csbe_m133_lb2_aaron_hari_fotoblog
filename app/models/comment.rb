class Comment < ApplicationRecord

  # Defines the relationship to the model user, and picture.
  belongs_to :user
  belongs_to :picture

  validates_presence_of :comment
end
