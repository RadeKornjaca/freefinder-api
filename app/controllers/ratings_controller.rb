class RatingsController < AuthenticationController

  def show
    @rating
  end

  def create
    @rating = Rating.new(ratings_params)
    @rating.user_id = @current_user.id
    @rating.place_id = params[:place_id]

    if @rating.save
      render :show, status: :created
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

#  def update
#    @rating = Rating.find_or_initialize_by(place_id: params[:place_id], user_id: current_user.id)
#
#    if @rating.update(rating: params[:rating])
#      render :show
#    else
#      render json: @rating.errors, status: :unprocessable_entity
#    end
#  end

  private
    def ratings_params
      params.require(:rating).permit(:status)
    end

end
