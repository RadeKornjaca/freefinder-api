class RenameCategoriesColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :category_id, :parent_category_id
  end
end
