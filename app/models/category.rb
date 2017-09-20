class Category < ApplicationRecord
  belongs_to :parent_category, optional: true, class_name: 'Category'

  validates :name, uniqueness: true, presence: true

  scope :after_last_update, lambda { |last_updated_timestamp| where('updated_at >= ?', last_updated_timestamp) }

  def self.fetch_categories(update_timestamp)
    if update_timestamp
      self.after_last_update(update_timestamp)
    else
      all
    end
  end

end
