# app/services/tmdb_service.rb
class TmdbService
    include HTTParty
    base_uri 'https://api.themoviedb.org/3'
  
    def initialize
      @headers = {
        "Authorization" => "Bearer #{ENV['TMDB_READ_ACCESS_TOKEN']}",
        "Content-Type" => "application/json;charset=utf-8"
      }
    end
  
    def fetch_popular_movies
      self.class.get("/movie/popular", headers: @headers)
    end
  end
  