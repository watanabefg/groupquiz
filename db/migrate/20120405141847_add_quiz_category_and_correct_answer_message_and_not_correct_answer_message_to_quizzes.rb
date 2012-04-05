class AddQuizCategoryAndCorrectAnswerMessageAndNotCorrectAnswerMessageToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :quiz_category, :text

    add_column :quizzes, :correct_answer_message, :text

    add_column :quizzes, :not_correct_answer_message, :text

  end
end
