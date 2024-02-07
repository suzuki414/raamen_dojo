class CreateReferences < ActiveRecord::Migration[6.1]
  def change
    create_table :references do |t|
      t.references :follower, null: false, foreign_key: true
      t.references :followed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
