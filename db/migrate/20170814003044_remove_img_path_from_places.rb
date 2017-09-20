class RemoveImgPathFromPlaces < ActiveRecord::Migration[5.0]
  def change
    remove_column :places, :img_path, :string
  end
end
