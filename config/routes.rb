Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root "shashins#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :shashins, only: [:index, :show] do
  
   collection do
      get :ranking
    end

    member do
      post :favorite
      post :unfavorite
    end

  end

  resources :users, only: [ :show, :edit, :update] 
  
end
