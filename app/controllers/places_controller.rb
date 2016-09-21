class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :update, :destroy]

  # GET /places
  def index
    # @places = Place.all
    @places = Place.area(params[:top_lat],
                         params[:down_lat],
                         params[:top_long],
                         params[:down_long])

    render json: @places
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

  after_action :decode_image, :only => [:create, :update]

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
      params.require(:place).permit(:name, :lat, :lng, :encoded_image, :likes, :dislikes, :inappropriate, :category_id)
    end

end
