class AddScoreToLists < ActiveRecord::Migration[6.1]
  def change
    add_column :ramen_noodle_comments, :score, :decimal, precision: 5, scale: 3
  end
end
