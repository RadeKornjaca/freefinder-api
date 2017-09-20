class User < ApplicationRecord
  has_secure_password

  has_many :api_keys
  has_many :ratings
  has_many :places, through: :ratings

  validates :email, presence: true, uniqueness: true
end
