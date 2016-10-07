class User < ApplicationRecord
  has_secure_password

  has_many :api_keys

  validates_uniqueness_of :email
end
