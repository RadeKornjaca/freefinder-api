class PlacesController < AuthenticationController
  before_action :set_place, only: [:show, :update, :destroy]

  # GET /places
  def index
    proposable_ids = Place.includes(:revisions)
                          .where.not(revisions: { proposable_id: nil })
                          .pluck(:proposable_id)

    @places = Place.area(params[:min_lat],
                         params[:max_lat],
                         params[:min_lng],
                         params[:max_lng])
                   .without_proposables(proposable_ids)
                   .by_category(params[:category_id])
                   .by_name(params[:name])
                   .includes([ :category, :ratings ])
#                  .where(ratings: { user_id: @current_user.id })

    # render json: @places, include: :category
    # @places.includes( [:category, :ratings] )
  end

  # GET /places/1
  def show
    render json: @place
  end

  # POST /places
  def create
    @place = Place.new(place_params)

    if @place.save
      render json: @place, status: :created, location: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /places/1
  def update
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # DELETE /places/1
  def destroy
    @place.destroy
  end

  # after_action :decode_image, :only => [:create, :update]

  private
    def decode_image
      ImageWorker.perform_async(params[:encoded_image], @place.id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def place_params
      params.require(:place).permit(:name, :description, :lat, :lng, :encoded_image, :rate, :category_id)
    end

end
