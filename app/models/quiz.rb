#encoding:UTF-8
class Quiz < ActiveRecord::Base
  validates :category_id, :presence => true
  belongs_to :category
  belongs_to :user
  belongs_to :group

  def self.build_from_csv(row,user_id,group_id)
    data = {
      :quiz_title => row[0].to_s.force_encoding("utf-8"),
      :quiz_contents => row[1].to_s.force_encoding("utf-8"),
      :category_id => row[2].to_s.force_encoding("utf-8"),
      :correct_answer_message => row[3].to_s.force_encoding("utf-8"),
      :not_correct_answer_message => row[4].to_s.force_encoding("utf-8"),
      :user_id => user_id,
      :quiz_answer1 => row[5].to_s.force_encoding("utf-8"),
      :quiz_answer2 => row[6].to_s.force_encoding("utf-8"),
      :quiz_answer3 => row[7].to_s.force_encoding("utf-8"),
      :quiz_answer4 => row[8].to_s.force_encoding("utf-8"),
      :quiz_answer_radio => row[9].to_s.force_encoding("utf-8"),
      :group_id => group_id,
      :correct_answer_message2 => row[10].to_s.force_encoding("utf-8"),
      :correct_answer_message3 => row[11].to_s.force_encoding("utf-8"),
      :correct_answer_message4 => row[12].to_s.force_encoding("utf-8")
    }

    return data
  end

end
