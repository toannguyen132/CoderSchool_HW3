class User < ApplicationRecord
  has_many :events
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  has_secure_password
end
