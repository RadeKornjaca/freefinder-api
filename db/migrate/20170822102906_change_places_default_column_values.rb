class ChangePlacesDefaultColumnValues < ActiveRecord::Migration[5.0]
  def change
    change_column_default :places, :likes, 0
    change_column_default :places, :dislikes, 0
    change_column_default :places, :inappropriate, 0
  end
end
