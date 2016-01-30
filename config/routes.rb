Rails.application.routes.draw do
  
  root 'welcome#index'
  namespace :admin do
    root 'dashboard#index'
    resources :authors
    resources :books  
    resources :topics do
      resources :topic_aliases
    end
    resources :quote_topic_suggestions
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
