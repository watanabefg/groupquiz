# encoding:UTF-8
module ApplicationHelper
  def title
    base_title = "Groupquiz:クイズで楽しく情報共有"
    if @title.nil?
      base_title
    else
      #{base_title} | #{@title}
    end
  end
end
