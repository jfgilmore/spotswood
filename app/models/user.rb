class User < ApplicationRecord
  has_one_attached :avatar, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :interactions
  enum role: %i[user moderator admin]

  after_initialize do
    if self.new_record?
      self.role ||= :user
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable

  validates :name, :email, presence: true
  validates :name, length: { in: 2...50 }
  validates :password, length: { minimum: 6 }, presence: true, on: :create
  # Code of conduct validated but not saved as all users MUST accept
  validates :coc, acceptance: true

end
