Rails.application.routes.draw do
  root 'welcome#index'
  namespace :admin do
    root 'dashboard#index'
  end
end
