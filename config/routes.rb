# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'project/index'
  # get 'project/new'
  resources :projects
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'home#index'
end
