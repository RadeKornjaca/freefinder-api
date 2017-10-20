class RevisionService
  THRESHOLD = 0.5

  def initialize(revision)
    @revision = revision
  end

  def update_information
    if threshold(@revision.positive)
      current_info = @revision.revisionable

      current_info.update_info(@revision.proposable)
      @revision.destroy
    end
  end

  def reject_revision
    @revision.destroy if threshold(@revision.negative)
  end

private

  def threshold(number_of_votes)
    (number_of_votes.to_f / @revision.revisionable.unique_visitors.count) > THRESHOLD
  end

end
