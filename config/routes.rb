Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users

  resources :media_items

  resources :video_items, only: [:show, :new, :edit, :create] do
    resources :links
  end

  resources :link_items, only: [:show, :new, :edit, :create]

  resources :web_items, only: [:show, :new, :edit, :create] do
    resources :links
  end

end
