json.(category, :id, :name)

json.parent_category do |json|
  json.(category.parent_category, :id, :name) if category.parent_category != nil

  json.additional_fields category.parent_category.additional_fields, :id, :name, :field_type unless category.parent_category.nil?
end

json.additional_fields category.additional_fields, :id, :name, :field_type

