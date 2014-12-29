class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.text :description
      t.string :url
      t.integer :user_id
      t.date :start_day
      t.date :end_day

      t.timestamps
    end
    add_index :subjects, [:user_id, :created_at]
    add_index :subjects, :url, unique: true
  end
end
