# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories
  has_many :exams
  has_many :questions, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :results

  enum role: %i[member admin]
end
