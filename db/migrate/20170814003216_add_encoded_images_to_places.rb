class AddEncodedImagesToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :encoded_image, :string
  end
end
