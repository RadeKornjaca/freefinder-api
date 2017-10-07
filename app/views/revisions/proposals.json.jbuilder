
json.partial! 'categories/show', collection: @revisions.map{ |r| r.proposable }, as: :category

