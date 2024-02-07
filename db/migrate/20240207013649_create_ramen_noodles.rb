class CreateRamenNoodles < ActiveRecord::Migration[6.1]
  def change
    create_table :ramen_noodles do |t|
      t.references :member, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.text :recipe
      t.float :average_rating, default: 0
      t.float :taste_rating, default: 0
      t.float :cook_time_rating, default: 0
      t.float :process_rating, default: 0
      t.float :difficulty_rating, default: 0
      t.integer :status

      t.timestamps
    end
  end
end
