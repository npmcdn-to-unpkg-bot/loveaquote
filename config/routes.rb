Rails.application.routes.draw do
  
  get "authors/:slug", to: redirect("/people/%{slug}", status: 301)
  
  resources :people, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
    end
    
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
    end
  end
  
  resources :books, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
    end  
    
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
    end
  end
  
  resources :topics, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
    end
    
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
    end
  end
  
  resources :quotes, only: [] do
    member do
      get 'pinterest'
      get 'facebook'
      get 'twitter'
      get 'google_plus'
    end
  end
    
  devise_for :admins, path: "admin", path_names: {sign_in: "login", sign_out: "logout"}, controllers: {sessions: "admin/sessions"}
  
  get "/404" => "exceptions#serve_404", as: "serve_404"

  get "/500" => "exceptions#serve_500"

  root 'welcome#index'
  
  namespace :admin do
    root 'dashboard#index'
    resources :quotes
    resources :people
    resources :books
    resources :characters
    resources :featured_topics
    resources :topics do
      resources :topic_aliases
    end
    resources :quote_topic_suggestions, only: [:index], path: "quote-topic-suggestions" do
      member do
        get 'accept', as: 'accept'
        get 'decline', as: 'decline'
      end
    end
    resources :settings
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
