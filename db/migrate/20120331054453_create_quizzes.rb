class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :quiz_title
      t.text :quiz_contents
      t.text :quiz_answer

      t.timestamps
    end
  end
end
