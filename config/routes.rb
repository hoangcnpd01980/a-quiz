# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "/categories/:id", to: "home#show"

  namespace :admin do
    get "/dashboard", to: "dashboard#index"
    resources :crawler_questions, only: %i(index create destroy)
    resources :categories, except: %i(new edit)
  end

  namespace :api do
    namespace :v1 do
      resources :exams, only: [:index, :create, :destroy, :show]
    end
  end

  devise_for :users
  resources :questions
  resources :exams
  mount ActionCable.server => '/cable'
  resources :categories, only: [:show]
end
