class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.float :lat
      t.float :lng
      t.string :img_path
      t.integer :likes
      t.integer :dislikes
      t.integer :inappropriate
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
