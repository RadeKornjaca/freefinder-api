class CreateRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :revisions do |t|
      t.integer :positive, default: 0
      t.integer :negative, default: 0
      t.references :revisionable, polymorphic: true, index: true
      t.references :proposable, polymorphic: true, index: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
