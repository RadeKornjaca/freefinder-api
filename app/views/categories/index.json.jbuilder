json.updateTimestamp Time.now.utc

json.categories do
  json.partial! "show", collection: @categories, as: :category
end
