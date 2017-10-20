class CategoriesController < AuthenticationController
  before_action :set_category, only: [:show, :update, :destroy, :visit]

  # GET /categories
  def index
    update_timestamp = params[:update_timestamp]

    proposable_ids = Category.includes(:revisions).where.not(revisions: { proposable_id: nil }).pluck(:proposable_id)
    @categories = Category.fetch_categories(update_timestamp, proposable_ids)

    # render json: @categories, include: :category
    # render 'categories/index'
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  # PUT /categories/1/visit
  def visit
    @category.unique_visitors << @current_user unless @category.unique_visitors.exists?(@current_user.id)
    @category.save

    render json: '{}'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :parent_category_id)
    end
end
