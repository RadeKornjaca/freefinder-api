class Category < ApplicationRecord
  belongs_to :category, :optional => true
end
