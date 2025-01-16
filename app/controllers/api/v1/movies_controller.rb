# app/controllers/api/v1/movies_controller.rb
class Api::V1::MoviesController < ApplicationController
    def popular
      tmdb_service = TmdbService.new
      response = tmdb_service.fetch_popular_movies
  
      response["results"].each do |movie_data|
        Movie.find_or_create_by(tmdb_id: movie_data["id"]) do |movie|
          movie.title         = movie_data["title"]
          movie.overview      = movie_data["overview"]
          movie.poster_path   = movie_data["poster_path"]
          movie.backdrop_path = movie_data["backdrop_path"]
          movie.release_date  = movie_data["release_date"]
          movie.genre_ids     = movie_data["genre_ids"]
          movie.popularity    = movie_data["popularity"]
          movie.vote_average  = movie_data["vote_average"]
          movie.vote_count    = movie_data["vote_count"]
        end
      end
  
      render json: { message: "Movies saved successfully!" }
    end
  end
  