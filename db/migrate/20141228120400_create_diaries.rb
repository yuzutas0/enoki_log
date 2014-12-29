class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.date :day
      t.string :todo
      t.string :done
      t.integer :progress
      t.string :memo
      t.integer :subject_id

      t.timestamps
    end
    add_index :diaries, :subject_id
  end
end
