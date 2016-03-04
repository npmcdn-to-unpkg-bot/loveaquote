Rails.application.routes.draw do
  
  get "authors/:slug", to: redirect("/people/%{slug}", status: 301)
  get "authors/:slug/:page", to: redirect("/people/%{slug}/%{page}", status: 301)
  
  resources :people, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
    end
    
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
      get 'pinterest'
      get 'facebook'
      get 'twitter'
      get 'google_plus'
    end
  end
  
  resources :books, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
    end  
    
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
      get 'pinterest'
      get 'facebook'
      get 'twitter'
      get 'google_plus'
    end
  end
  
  resources :topics, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
    end
    
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
      get 'pinterest'
      get 'facebook'
      get 'twitter'
      get 'google_plus'
    end
  end
  
  resources :movies, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
    end
    
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
      get 'pinterest'
      get 'facebook'
      get 'twitter'
      get 'google_plus'
    end
  end
  
  resources :tv_shows, only: [:index, :show], path: "tv-shows" do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
    end
    
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
      get 'pinterest'
      get 'facebook'
      get 'twitter'
      get 'google_plus'
    end
  end
  
  resources :characters, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
    end
    
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
      get 'pinterest'
      get 'facebook'
      get 'twitter'
      get 'google_plus'
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

  resources :messages, path: "contact-us", only: [:new, :create] do
    collection do
      get "success", action: "success", as: "success"
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
    resources :movies
    resources :tv_shows, path: "tv-shows"
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
    resources :messages, only: [:index, :show, :destroy]
    resources :settings
    resources :nationalities
    resources :professions
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
