module UniqueVisitable
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :unique_visitors, class_name: "User"
  end
end
