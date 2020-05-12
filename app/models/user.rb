class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :lockable

  validates :name, presence: true, length: { in: 2...50 }
  validates :email, presence: true
  validates :phone, numericality: { only_integer: true }, length: { in: 8...10 }
  # Code of conduct validated but not saved as all users MUST accept
  validates :coc, acceptance: true

  enum role: %i[Guest CommunityUser CommunityModerator Moderator Admin]

  has_one_attached :avatar
end
