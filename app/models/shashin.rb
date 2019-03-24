class Shashin < ApplicationRecord
  validates_presence_of :title

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

end
