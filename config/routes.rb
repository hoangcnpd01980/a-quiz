# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  namespace :admin do 
    get "/dashboard", to: "dashboard#index"
  end

  namespace :api do
    namespace :v1 do
      resources :exams, only: [:index, :create, :destroy, :show]
    end
  end
  
  devise_for :users
  resources :questions
  resources :exams
end
