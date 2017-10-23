class CreateAdditionalFields < ActiveRecord::Migration[5.0]
  def change
    create_table :additional_fields do |t|
      t.string :name
      t.string :field_type
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
