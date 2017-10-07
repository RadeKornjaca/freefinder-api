class Category < ApplicationRecord
  include Revisionable

  belongs_to :parent_category, optional: true, class_name: 'Category'
  has_one    :proposal, as: :proposable

#  validates :name, uniqueness: true, presence: true
  validates :name, presence: true

  scope :after_last_update, lambda { |last_updated_timestamp| where('updated_at >= ?', last_updated_timestamp) }
  scope :without_proposables, lambda { |proposable_ids| where.not(id: proposable_ids) }

  def self.fetch_categories(update_timestamp, proposable_ids)
    if update_timestamp
      self.includes(:parent_category)
          .without_proposables(proposable_ids)
          .after_last_update(update_timestamp)
    else
      self.includes(:parent_category)
          .without_proposables(proposable_ids)
    end
  end

end
