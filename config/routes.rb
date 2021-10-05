# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    member do
      patch :add_user
      delete :remove_user
    end

    resources :bugs do
      member do
        patch :assign
        patch :change_status
      end
    end
  end

  root to: 'home#index'

  match '*path' => redirect('/'), via: %i[get post]
end
