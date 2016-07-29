Rails.application.routes.draw do
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]  
  get 'static_pages/privacy_policy'
  get 'static_pages/about_us'
  get 'static_pages/disclaimer'
  get 'static_pages/terms_and_conditions'

  get "system/*path", to: redirect("/", status: 301)
  get "pictures", to: redirect("/", status: 301)
  get "pictures/*path", to: redirect("/", status: 301)
  get "quote-of-the-day", to: redirect("/", status: 301)
  get "quote-of-the-day/*path", to: redirect("/", status: 301)
  get "authors", to: redirect("/people", status: 301)
  get "authors/:slug", to: redirect("/people/%{slug}", status: 301)
  get "authors/:slug/:page", to: redirect("/people/%{slug}/%{page}", status: 301)

  devise_for :users, path: "my", controllers: {omniauth_callbacks: "my/omniauth_callbacks"}
  devise_scope :user do
    get 'login', :to => 'my/sessions#new', :as => :new_user_session
    get 'logout', :to => 'my/sessions#destroy', :as => :destroy_user_session
  end
  
  devise_for :admins, path: "admin", path_names: {sign_in: "login", sign_out: "logout"}, controllers: {sessions: "admin/sessions"}

  resources :people, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
      get 'feed'
    end

    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
      get ':featured_topic', action: 'featured_topic', as: 'featured_topic', featured_topic: /on-.+/, format: true
      get 'facebook'
      get 'pinterest'
      get 'twitter'
      get 'google_plus'
      get ':redirect_to_person', action: 'redirect_to_person', constraints: { page: /\D+/ }
    end
  end

  resources :proverbs, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
      get 'feed'
    end
    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
      get ':featured_topic', action: 'featured_topic', as: 'featured_topic', featured_topic: /on-.+/, format: true
      get 'pinterest'
      get 'facebook'
      get 'twitter'
      get 'google_plus'
      get ':redirect_to_proverb', action: 'redirect_to_proverb', constraints: { page: /\D+/ }
    end
  end

  resources :books, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
      get 'feed'
    end

    member do
      get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
      get 'pinterest'
      get 'facebook'
      get 'twitter'
      get 'google_plus'
      get ':redirect_to_book', action: 'redirect_to_book', constraints: { page: /\D+/ }
    end
  end

  namespace :topics do
    resources :topic_combinations, path: "combinations", only: [:index, :show] do
      member do
        get ':page', action: 'show', constraints: { page: /\d+/ }, as: 'page'
        get 'pinterest'
        get 'facebook'
        get 'twitter'
        get 'google_plus'
      end
    end
  end

  resources :topics, only: [:index, :show] do
    collection do
      get ':alphabet', action: 'alphabet', as: 'alphabet', alphabet: /[A-Z]/
      get 'feed'
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
      get 'feed'
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
      get 'feed'
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
      get 'feed'
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
  resources :subscribers, only: [:create]

  get 'feed' => 'welcome#feed', :as => :feed
  get 'privacy-policy' => 'static_pages#privacy_policy', as: :privacy_policy
	get 'about-us' => 'static_pages#about_us', as: :about_us
	get 'disclaimer' => 'static_pages#disclaimer', as: :disclaimer
	get 'terms-and-conditions' => 'static_pages#terms_and_conditions', as: :terms_and_conditions

  get "/404" => "exceptions#serve_404", as: "serve_404"

  get "/500" => "exceptions#serve_500"

  root 'welcome#index'

  namespace :admin do
    root 'dashboard#index'
    get "regenerate-social-images" => "dashboard#regenerate_social_images", as: :regenerate_social_images
    get "regenerate-quote-images" => "dashboard#regenerate_quote_images", as: :regenerate_quote_images
    
    resources :users, only: [:index, :destroy]
    resources :subscribers, only: [:index, :destroy]
    
    resources :quotes do
      member do
        get "verify"
        get "tweetable"
        get "image"
      end
    end
    resources :people do
      member do
        get "review"
        get ':featured_topic', action: 'featured_topic', as: 'featured_topic', featured_topic: /on-.*/
      end
    end
    resources :books do
      member do
        get "review"
      end
    end
    resources :movies do
      member do
        get "review"
      end
    end
    resources :proverbs do
      member do
        get "review"
      end
    end
    resources :tv_shows, path: "tv-shows" do
      member do
        get "review"
      end
    end
    resources :characters do
      member do
        get "review"
      end
    end

    resources :featured_topics
    resources :topics do
      member do
        get "review"
      end
      resources :topic_aliases
    end
    resources :topic_combinations, only: [:index, :show], path: "topic-combinations"
    resources :quote_topic_suggestions, only: [:index], path: "quote-topic-suggestions" do
      member do
        get 'accept', as: 'accept'
        get 'decline', as: 'decline'
      end
    end
    resources :tweetable_quotes, path: "tweetable-quotes", only: [:index, :destroy]
    resources :quote_of_the_days, path: "quote-of-the-day", only: [:index]
    resources :color_schemes, path: "color-schemes"
    resources :messages, only: [:index, :show, :destroy]
    resources :logs, only: [:index, :destroy]
    resources :redirects, except: [:show]
    resources :settings
    resources :nationalities
    resources :professions
  end

  namespace :my do
    root "dashboard#index"
    get "mark-for-deletion" => "dashboard#mark_for_deletion", as: :account_mark_for_deletion
    get "unmark-for-deletion" => "dashboard#unmark_for_deletion", as: :account_unmark_for_deletion
    resources :user_lists, path: "lists"
    resources :user_quotes, path: "quotes", except: [:show]
  end
end