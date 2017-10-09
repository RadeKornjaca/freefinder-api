class Place < ApplicationRecord
  include Revisionable

  belongs_to :category
  has_one    :proposal, as: :proposable
  has_many   :ratings
  has_many   :users, through: :ratings

  validates :name, :lat, :lng, :category, presence: true

  # has_attached_file :image

  scope :upper_area, lambda { |min_lat| where('lat >= ?', min_lat) }
  scope :down_area,  lambda { |max_lat| where('lat <= ?', max_lat) }
  scope :right_area, lambda { |min_long| where('lng >= ?', min_long) }
  scope :left_area,  lambda { |max_long| where('lng <= ?', max_long) }

  scope :without_proposables, lambda { |proposable_ids|
    where.not(id: proposable_ids)
  }

  scope :by_category, lambda { |category_id|
    where(category_id: category_id) if category_id.present?
  }

  scope :by_name, lambda { |name|
    where(name: name) if name.present?
  }

  def self.area(min_lat, max_lat, min_long, max_long)
    self.down_area(max_lat).
         upper_area(min_lat).
         left_area(max_long).
         right_area(min_long)
  end

  # validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }

end
