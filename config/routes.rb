Rails.application.routes.draw do
  root :to => "pages#home"

  get '/flights/search' => 'flights#search', :as => 'search_flights'
  post '/flights/search' => 'flights#results', :as => 'results_flights'

  resources :users
  resources :flights

  get '/sessions/new' => 'sessions#new'
  post '/sessions/create' => 'sessions#create'
  get '/sessions/destroy' => 'sessions#destroy', :as => 'sessions_destroy'

  post '/flights/book/:id' => 'flights#book', :as => 'flight_book'
  get '/flights/cancel/:id' => 'flights#cancel', :as => 'flight_cancel'
end
