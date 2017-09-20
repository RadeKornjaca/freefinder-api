
json.array! @places do |place|
json.(place, :id,
             :name,
             :description,
             :lat, 
             :lng, 
             :likes,
             :dislikes,
             :category,
             :ratings,
             :encoded_image
     )
end
