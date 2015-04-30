class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]

  validates :role, presence: true

  has_many :media_items

  after_initialize :set_default_role, :if => :new_record?

  private

  def set_default_role
    self.role ||= :user
  end
end
