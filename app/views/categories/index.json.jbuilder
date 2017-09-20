json.updateTimestamp Time.now.utc

json.categories do
  json.array! @categories do |category|
    json.(category, :id, :name)
    json.parentCategory do |json|
      json.(category.parent_category, :id, :name) if category.parent_category != nil
    end
  end
end
