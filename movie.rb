class Movie
  attr_reader :title, :genre, :movie_timings, :available_seats
  @@movies = []

  def initialize(title, genre, movie_timings, total_seats)
    @title = title
    @genre = genre.to_sym
    @movie_timings = movie_timings
    @available_seats = Array.new(movie_timings.size) { total_seats }
    @@movies << self
  end

  def self.all_movies
    @@movies
  end 
end

