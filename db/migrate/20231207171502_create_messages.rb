class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :text, null: false
      t.references :user, null: false, foreign_key: true 
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
