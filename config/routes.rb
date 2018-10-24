Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :boardgames
      resources :users
      post '/boardgames/search', to: 'boardgames#search'
      post '/boardgames/search_by_id', to: 'boardgames#search_by_id'
      post '/collections/search', to: 'collections#search'
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
    end
  end

end
