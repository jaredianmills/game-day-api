Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :boardgames
      resources :users
      post '/boardgames/search', to: 'boardgames#search'
      post '/collections/search', to: 'collections#search'
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
    end
  end

end
