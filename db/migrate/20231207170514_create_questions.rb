class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.boolean :closed, null: false, default: false
      t.references :user, null:false, foreign_key: true

      t.timestamps
    end
  end
end
