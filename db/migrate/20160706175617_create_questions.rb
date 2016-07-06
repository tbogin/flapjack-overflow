class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :body
      t.integer :user_id, null: false
      t.integer :views, default: 0

      t.timestamps null: false
    end
  end
end
