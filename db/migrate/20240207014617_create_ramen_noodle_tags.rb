class CreateRamenNoodleTags < ActiveRecord::Migration[6.1]
  def change
    create_table :ramen_noodle_tags do |t|
      t.references :ramen_noodle, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
