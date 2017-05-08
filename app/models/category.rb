class Category < ApplicationRecord
  belongs_to :category, optional: true

  validates :name, presence: true
end
