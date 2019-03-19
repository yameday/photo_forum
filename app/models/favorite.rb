class Favorite < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :like, class_name: "User"

  validates :like_id, uniqueness: { scope: :user_id }
end
