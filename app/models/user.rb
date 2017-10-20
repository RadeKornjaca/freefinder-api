class User < ApplicationRecord
  has_secure_password

  has_many                :api_keys
  has_many                :ratings
  has_many                :places, through: :ratings
  has_and_belongs_to_many :visited_categories, class_name: "Category"
  has_and_belongs_to_many :visited_places, class_name: "Place"

  validates :email, presence: true, uniqueness: true
end
