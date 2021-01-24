Rails.application.routes.draw do
  get '/flights/search' => 'flights#search', :as => 'search_flights_path'  
  root :to => "pages#home"
  resources :users
  resources :flights
end
