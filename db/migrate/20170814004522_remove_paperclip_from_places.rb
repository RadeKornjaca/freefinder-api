class RemovePaperclipFromPlaces < ActiveRecord::Migration[5.0]
  def change
    remove_column :places, :image_file_name
    remove_column :places, :image_content_type
    remove_column :places, :image_file_size
    remove_column :places, :image_updated_at
  end
end
