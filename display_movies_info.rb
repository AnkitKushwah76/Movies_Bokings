class DisplayMovieInfo

  def self.display_all_movies
    puts "\nAvailable Movies:"
    puts "Movie Number \t\tMovie Title \t\tMovie Genre"
    Movie.all_movies.each_with_index do |movie, index|
      puts "#{index + 1} \t\t\t#{movie.title} \t\t(#{movie.genre})"
    end
    show_menu_movies
  end


  def self.show_available_seats(movie_number)
    booking_system = BookingSystem.new
    movie = Movie.all_movies[movie_number]

    if movie_number < 0 || movie.nil?
      display_error_message('Invalid choice. Please enter a valid movie number')
      display_all_movies
      return
    end

    display_seats_availability_status(movie)

    puts "\nEnter 1 to book ticktes"
    puts "\Enter 2 to go home page"
    puts "Enter your choice: "
    choice = gets.chomp.to_i
    main if choice!=1
    puts "\nEnter the show time index number for which you want to book the tickets: "
    show_index = gets.chomp.to_i - 1

    if show_index < 0 || movie.movie_timings.size < show_index
      display_error_message('Invalid choice. Show Timings Index Please enter a valid index number')
      show_available_seats(movie_number)
      return
    end 

    booking_system.tickets_booking(movie_number, show_index)
  end

  def self.display_seats_availability_status(movie)
    booked_tickets = BookingSystem.get_booked_tickets
    puts "\nShow Timings for movie #{movie.title}:"
    puts ''
    puts "Index \t\tTime\t\tSeats Status"
    movie.movie_timings.each_with_index do |timing, index|
      booked_seats = booked_tickets.count { |b| b[:movie_title] == movie.title && b[:time] == timing }
      puts "#{index + 1}. \t\t#{timing} \tBooked(#{booked_seats}) (#{movie.available_seats[index]} seats available)"
    end
  end
end
