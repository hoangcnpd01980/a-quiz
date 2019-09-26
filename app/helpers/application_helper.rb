# frozen_string_literal: true

module ApplicationHelper
  def select_category
    Category.all.map { |c| [c.name, c.id] }
  end

  def select_level
    Question.levels.keys.map { |q| [q.titleize, q] }
  end

  def full_title(page_title = "")
    base_title = t "a-quiz"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
