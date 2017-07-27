class Category < ApplicationRecord
  belongs_to :category, optional: true

  validates :name, presence: true

  scope :after_last_update, lambda { |last_updated_timestamp| where('updated_at >= ?', last_updated_timestamp) }

  def self.fetch_categories(update_timestamp)
    if update_timestamp
      self.after_last_update(update_timestamp)
    else
      all
    end
  end

  def parent_category
    Category.find(category_id) if category_id
  end
end
