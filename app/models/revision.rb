class Revision < ApplicationRecord
  belongs_to :user
  belongs_to :revisionable, polymorphic: true
  belongs_to :proposable,   polymorphic: true, dependent: :destroy

#  accepts_nested_attributes_for :proposable

end
