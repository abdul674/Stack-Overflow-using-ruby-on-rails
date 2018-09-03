class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.integer :votes, default: 0

      t.timestamps
    end
  end
end
