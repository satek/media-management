Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users

  resources :media_items do
    resources :links
  end

  resources :video_items, only: [:show, :edit, :update]

  resources :link_items, only: [:show, :edit, :update]

  resources :image_items, only: [:show, :edit, :update]

end
