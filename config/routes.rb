Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'movies/popular', to: 'movies#popular'
      get 'movies/search', to: 'movies#search'
    end
  end
end
