# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users   # , controllers: { registrations: 'users/registrations' }

  resources :projects do
    resources :bugs
  end
  root to: 'home#index'
end
