Rails.application.routes.draw do
  devise_for :users

  root "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :edit, :update] do
    
    collection do
      get :ranking
    end

    member do
      post :favorite
      post :unfavorite
    end


  end
   
  resources :favorites, only: [:create, :destroy]
end
