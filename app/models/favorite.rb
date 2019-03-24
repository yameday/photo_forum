class Favorite < ApplicationRecord

  belongs_to :user, counter_cache: true
  belongs_to :shashin, counter_cache: true

end
