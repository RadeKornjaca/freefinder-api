module RevisionUpdateable
  extend ActiveSupport::Concern

  def update_from_revision
    raise 'Not implemented by class!'
  end
end
