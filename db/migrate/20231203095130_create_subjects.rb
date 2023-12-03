class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :name, null: false
      t.float :score
      t.integer :max_score, null: false
      t.float :average_score
      t.integer :rank
      t.integer :rank_range
      t.references :result, null: false, foreign_key: true

      t.timestamps
    end
  end
end
