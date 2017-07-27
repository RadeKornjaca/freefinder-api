json.update_timestamp Time.now.utc

json.categories do
  json.array! @categories do |category|
    json.(category, :id, :name)
    json.parent_category do |json|
      json.(category.category, :id, :name) if category.category != nil
    end
  end
end
