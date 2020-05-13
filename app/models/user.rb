class User < ApplicationRecord
  # scope :admin, -> { where(role: :admin) }
  # scope :user, -> { where(role: :user) }
  # scope :moderator, -> { where(role: :moderator) }
  after_initialize do
    if self.new_record?
      self.role ||= :user
    end
  end
  enum role: %i[user moderator admin]
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable

  validates :name, :email, presence: true
  validates :name, length: { in: 2...50 }
  validates :password, :password_confirmation, length: { minimum: 6 }, on: :create
  # Code of conduct validated but not saved as all users MUST accept
  validates :coc, acceptance: true

  has_one_attached :avatar
end
