# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    member do
      get :add_user
      get :remove_user
    end
    resources :bugs do
      get :assign, on: :member
      get :change_status, on: :member
    end
  end

  root to: 'home#index'
end
