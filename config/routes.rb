Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :bands do
    resources :albums, only: [:new, :create]
  end

  resource :sessions, only: [:new, :create, :destroy]


  
end
