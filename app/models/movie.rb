# app/models/movie.rb
class Movie
    include Mongoid::Document
  
    field :tmdb_id, type: Integer
    field :title, type: String
    field :overview, type: String
    field :poster_path, type: String
    field :backdrop_path, type: String
    field :release_date, type: Date
    field :genre_ids, type: Array
    field :popularity, type: Float
    field :vote_average, type: Float
    field :vote_count, type: Integer
  end
  