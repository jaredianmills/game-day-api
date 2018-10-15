Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :boardgames
      post '/boardgames/search', to: 'boardgames#search'
    end
  end

end
