class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :member, null: false, foreign_key: true
      t.references :ramen_noodle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
