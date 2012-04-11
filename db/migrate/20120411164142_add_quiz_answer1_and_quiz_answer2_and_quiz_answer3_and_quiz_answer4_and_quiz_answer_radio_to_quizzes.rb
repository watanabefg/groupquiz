class AddQuizAnswer1AndQuizAnswer2AndQuizAnswer3AndQuizAnswer4AndQuizAnswerRadioToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :quiz_answer1, :text

    add_column :quizzes, :quiz_answer2, :text

    add_column :quizzes, :quiz_answer3, :text

    add_column :quizzes, :quiz_answer4, :text

    add_column :quizzes, :quiz_answer_radio, :integer

  end
end
