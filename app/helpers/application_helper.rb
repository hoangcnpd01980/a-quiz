# frozen_string_literal: true

module ApplicationHelper
  def select_category
    Category.all.map { |c| [c.name, c.id] }
  end

  def select_level
    Question.levels.keys.map { |q| [q.titleize, q] }
  end
end
