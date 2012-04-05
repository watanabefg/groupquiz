class ChangeQuizCategoryTextToInteger < ActiveRecord::Migration
  def up
    rename_column(:quizzes, :quiz_category, :category_id)
    change_column :quizzes, :category_id, :integer
  end

  def down
  end
end
