class RevisionsController < AuthenticationController
  before_action :set_revision,     only: [:approve, :disprove]
  before_action :set_revisionable, only: [:create]

  def index
    revisionable_id = params[:category_id] or params[:place_id]
    @revisions = Revision.includes(:proposable)
                         .where(revisionable_id: revisionable_id)
  end

  # POST /revisions
  def create
    @revision = Revision.new
    @revision.user = @current_user
    @revision.revisionable = @revisionable
    @revision.proposable = @revision.revisionable_type.constantize.create!(revision_params[:proposable])

    if @revision.save
      render json: @revision, status: :created
    else
      render json: @revision.errors, status: :unprocessable_entity
    end
  end

  # PUT /revisions/:id/approve
  def approve
    @revision.increment!(:positive)

    render json: '{}'
  end

  # PUT /revisions/:id/disprove
  def disprove
    @revision.increment!(:negative)

    render json: '{}'
  end

  # GET /revisions/proposals
  def proposals
    revisionable_id = params[:category_id] or params[:place_id]
    @revisions = Revision.includes(:proposable)
                         .where(revisionable_id: revisionable_id)
  end

  private
    def set_revision
      @revision = Revision.find(params[:id])
    end

    def set_revisionable
      revisionable_id = (params[:category_id] or params[:place_id]).to_i
      revisionable_type, _ = params.keys.select { |key| key.include? '_id' }.first.split '_'
      @revisionable = revisionable_type.capitalize.constantize.find(revisionable_id)
    end

    def revision_params
      params.require(:revision).permit(:type, { proposable: proposable_params_types })
    end

    def proposable_params_types
      revisionable_type, _ = params.keys.select { |key| key.include? '_id' }.first.split '_'
      case revisionable_type
        when 'category'
          [ :name, :parent_category_id ]
        when 'place'
          [:name,
           :description,
           :category_id,
           :encoded_image,
           :lat,
           :lng]
      end
    end
end
