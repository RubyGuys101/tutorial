Rails.application.routes.draw do
  devise_for :authors

  resources :tags
  resources :articles do
    resources :comments
  end

  root to: 'articles#index'
end
