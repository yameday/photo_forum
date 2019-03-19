class Favorite < ApplicationRecord
  validates :like_id, uniqueness: { scope: :user_id }

  belongs_to :user, counter_cache: true
  belongs_to :like, class_name: "User"

end
