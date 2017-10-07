json.array! @revisions do |revision|
  json.(revision, :id,
                  :positive,
                  :negative
  )

  json.proposable do
    if revision.proposable.is_a?(Category)
      json.partial! 'categories/show', category: revision.proposable unless revision.proposable.nil?
    elsif revision.proposable.is_a?(Place)
      json.partial! 'places/show', place: revision.proposable unless revision.proposable.nil?
    end
  end
end
