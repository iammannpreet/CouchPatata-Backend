module Api
    module V1
      class MoviesController < ApplicationController
        def popular
          tmdb_service = TmdbService.new
          movies = tmdb_service.fetch_popular_movies
          render json: movies
        end
      end
    end
  end
  