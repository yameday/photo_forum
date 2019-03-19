class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :like, class_name: "User"

  validates :like_id, uniqueness: { scope: :user_id }
end
