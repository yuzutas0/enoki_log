class AddHiddenFlagToDiaries < ActiveRecord::Migration
  def change
    add_column :diaries, :hidden_flag, :boolean, :default => false
  end
end
