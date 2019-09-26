# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  namespace :admin do 
    get "/dashboard", to: "dashboard#index"
    resources :exams
  end

  namespace :api do
    namespace :v1 do
      resources :exams
    end
  end
  
  devise_for :users
  resources :questions
end
