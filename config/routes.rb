Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'movies/popular', to: 'movies#popular'
    end
  end
end
