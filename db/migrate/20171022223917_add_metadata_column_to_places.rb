class AddMetadataColumnToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :metadata, :jsonb
  end
end
