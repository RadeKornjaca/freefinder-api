class Place < ApplicationRecord
  belongs_to :category

  has_attached_file :image

  scope :down_area, lambda { |top_lat| where('lat <= ?', top_lat) }
  scope :upper_area, lambda { |down_lat| where('lat >= ?', down_lat) }
  scope :left_area, lambda { |down_long| where('lng <= ?', down_long) }
  scope :right_area, lambda { |top_long| where('lng >= ?', top_long) }

  scope :area, lambda { |top_lat, down_lat, top_long, down_long| self.down_area(top_lat).right_area(top_long).upper_area(down_lat).left_area(down_long) }

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

end
