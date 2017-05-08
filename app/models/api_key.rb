class ApiKey < ApplicationRecord
  before_create :generate_access_token

  belongs_to :user

  validates :access_token, presence: true
  validates_associated :user

  private
    def generate_access_token
      begin
        self.access_token = SecureRandom.hex
      end while self.class.exists?(:access_token => access_token)
    end
end
