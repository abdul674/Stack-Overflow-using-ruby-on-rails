class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :votes, default: 0
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
