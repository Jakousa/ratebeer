Rails.application.routes.draw do
  resources :memberships do
    post 'toggle_confirmed', on: :member
  end
  resources :beer_clubs
  resources :users do
    post 'toggle_blocked', on: :member
  end
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'breweries#index'

  post 'places', to:'places#search'

  get 'brewerylist', to:'breweries#list'
  get 'beerlist', to:'beers#list'
  get 'kaikki_bisset', to: 'beers#index'
  
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
  resources :styles, only: [:index, :show]
end
