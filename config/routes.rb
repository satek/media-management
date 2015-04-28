Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, controllers: {
                        sessions: "users/sessions",
                        registrations: "users/registrations"
                     }

  resources :media_items do
    resources :links
  end

  resources :video_items, only: [:show, :edit, :update]

  resources :link_items, only: [:show, :edit, :update]

  resources :image_items, only: [:show, :edit, :update] do
    resources :images
  end

end
