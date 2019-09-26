# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  namespace :admin do 
    get "/dashboard", to: "dashboard#index"
  end
  
  devise_for :users
  resources :questions
end
