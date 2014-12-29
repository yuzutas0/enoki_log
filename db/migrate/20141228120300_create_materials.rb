class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.string :link
      t.integer :subject_id

      t.timestamps
    end
    add_index :materials, :subject_id
  end
end
