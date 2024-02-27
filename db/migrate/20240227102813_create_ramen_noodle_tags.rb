class CreateRamenNoodleTags < ActiveRecord::Migration[6.1]
  def change
    create_table :ramen_noodle_tags do |t|
      t.references :ramen_noodle, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    # 同じタグは2回保存できない
    add_index :ramen_noodle_tags, [:ramen_noodle_id,:tag_id],unique: true
  end
end
