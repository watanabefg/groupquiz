class RemoveQuizAnswerFromQuizzes < ActiveRecord::Migration
  def up
    remove_column :quizzes, :quiz_answer
      end

  def down
    add_column :quizzes, :quiz_answer, :text
  end
end
