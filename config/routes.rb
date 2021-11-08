Rails.application.routes.draw do
  resources :tweets do
    resources :comments, only: [:create, :destroy]
  end
  get 'finder' => "finders#finder"
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :followings, :followers
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
