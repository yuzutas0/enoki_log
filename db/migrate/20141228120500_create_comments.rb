class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.boolean :owner_flag, :default => false
      t.integer :subject_id

      t.timestamps
    end
    add_index :comments, [:subject_id, :created_at]
  end
end
