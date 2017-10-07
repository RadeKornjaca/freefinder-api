module Revisionable
  extend ActiveSupport::Concern

  included do
    has_one  :proposal,  as: :proposable, class_name: 'Revision'
    has_many :revisions, as: :revisionable
  end
end
