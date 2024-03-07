class CreateRamenNoodleComments < ActiveRecord::Migration[6.1]
  def change
    create_table :ramen_noodle_comments do |t|
      t.references :member, null: false, foreign_key: true
      t.references :ramen_noodle, null: false, foreign_key: true
      t.string :comment
      t.decimal :score, precision: 5, scale: 3

      t.timestamps
    end
  end
end
