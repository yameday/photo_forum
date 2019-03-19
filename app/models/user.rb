class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :name
  
  mount_uploader :avatar, AvatarUploader
  
  has_many :favorites, dependent: :destroy
  has_many :like, through: :favorites

  def liking?(user)
    self.like.include?(user)
  end
end
