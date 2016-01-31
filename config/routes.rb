Rails.application.routes.draw do
  root 'welcome#index'
  
  devise_for :admins, path: "admin", path_names: {sign_in: "login", sign_out: "logout"}, controllers: {sessions: "admin/sessions"}
  namespace :admin do
    root 'dashboard#index'
    resources :quotes
    resources :authors
    resources :books  
    resources :topics do
      resources :topic_aliases
    end
    resources :quote_topic_suggestions, only: [:index], path: "quote-topic-suggestions" do
      member do
        get 'accept', as: 'accept'
        get 'decline', as: 'decline'
      end
    end
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
