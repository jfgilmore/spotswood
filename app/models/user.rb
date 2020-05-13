class User < ApplicationRecord
  after_initialize do
    if self.new_record?
      self.role ||= :User
    end
  end
  enum role: %i[User Moderator Admin]
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable

  validates :name, presence: true
  validates :name, length: { in: 2...50 }
  # Code of conduct validated but not saved as all users MUST accept
  validates :coc, acceptance: true

  has_one_attached :avatar
end
