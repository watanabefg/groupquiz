class AddCorrectAnswerMessage2ToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :correct_answer_message2, :text
    add_column :quizzes, :correct_answer_message3, :text
    add_column :quizzes, :correct_answer_message4, :text
  end
end
