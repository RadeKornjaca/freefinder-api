class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.belongs_to :user,  foreign_key: true
      t.belongs_to :place, foreign_key: true

      t.integer :rating, default: 0

      t.timestamps
    end
  end
end
