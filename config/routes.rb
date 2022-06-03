# frozen_string_literal: true

Rails.application.routes.draw do
  resources :challenges, only: [:show]
  resources :exercises, only: [:show] do
    resource :leaderboard
    resources :submissions, only: [:create]
  end
  namespace :admin do
    # Add dashboard for your models here
    resources :challenges
    resources :levels
    resources :exercises
    resources :assessments
    resources :result
    resources :invitations

    root to: "challenges#index" # <--- Root route
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resource :welcome, only: :update, controller: :welcome
  resources :get_started
  # Defines the root path route ("/")
  root "welcome#show"
end
