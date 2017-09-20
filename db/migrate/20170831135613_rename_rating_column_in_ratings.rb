class RenameRatingColumnInRatings < ActiveRecord::Migration[5.0]
  def change
    rename_column :ratings, :rating, :status
  end
end
