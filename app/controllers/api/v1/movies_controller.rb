# app/controllers/api/v1/movies_controller.rb
class Api::V1::MoviesController < ApplicationController
    def search
      title_query  = params[:title]
      genre_query  = params[:genre]
      release_year = params[:year]
      sort_by      = params[:sort_by] || 'popularity'
      order        = params[:order] || 'desc'
      page         = params[:page].to_i > 0 ? params[:page].to_i : 1
      limit        = params[:limit].to_i > 0 ? params[:limit].to_i : 10
  
      movies = Movie.all
  
      # 🔍 Fuzzy Title Search (Case-Insensitive with partial matching)
      if title_query.present?
        # Load all movie titles for fuzzy matching
      titles = movies.pluck(:title)
      fuzzy  = FuzzyMatch.new(titles)
      matched_titles = fuzzy.find_all(title_query)

      # Query MongoDB for matched titles
      movies = movies.where(:title.in => matched_titles)
    end
  
      # 🎬 Genre Search
      if genre_query.present?
        genre_id = genre_query.to_i
        movies = movies.where(genre_ids: genre_id)
      end
  
      # 📅 Partial Date Search (by Year)
      if release_year.present?
        movies = movies.where(:release_date.gte => Date.new(release_year.to_i, 1, 1),
                              :release_date.lte => Date.new(release_year.to_i, 12, 31))
      end
  
      # 🔃 Sorting
      if %w[popularity vote_average release_date].include?(sort_by)
        movies = movies.order_by(sort_by.to_sym => order == 'asc' ? :asc : :desc)
      end
  
      # 📄 Pagination
      movies = movies.skip((page - 1) * limit).limit(limit)
  
      # 📦 Response with Metadata
      render json: {
        current_page: page,
        per_page: limit,
        total_results: movies.count,
        movies: movies
      }
    end
  end
  