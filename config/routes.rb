Rails.application.routes.draw do
  # resources :prefectures, only: :index
  resources :prefectures, only: :index do
    get ':page', action: :index, on: :collection, as: ''
  end
  resources :addresses
  resources :users, only: [:index, :show, :new, :create] do
    collection do
      post '/confirm', to: 'users#confirm', as: :confirm
      get '/complete', to: 'users#complete', as: :complete
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
