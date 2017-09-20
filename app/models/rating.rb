class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :place

  after_save :update_rating_counter

  enum status: { like: 0, dislike: 1, report: 2 }

  def update_rating_counter
    @place = Place.find self.place_id
    
    case self.status
    when 'like'
      @place.likes += 1
    when 'dislike'
      @place.dislikes += 1
    when 'report'
      @place.inappropriate += 1
    end

    @place.save
  end
end
