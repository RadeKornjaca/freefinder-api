
json.(category, :id, :name)
json.parentCategory do |json|
  json.(category.parent_category, :id, :name) if category.parent_category != nil
end

