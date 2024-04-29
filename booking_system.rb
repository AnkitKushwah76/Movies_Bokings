require_relative 'movie'

class BookingSystem
  @@movies_bookings = []

  def self.get_booked_tickets
    @@movies_bookings
  end

  def self.show_tickets
    puts "\nAll tickets booked by you "
    puts "Ticket number \t\tMovie\t\tTime\t\tSeat Number"
    @@movies_bookings.each_with_index do |booking, index|
      puts "#{index + 1} \t\t\t#{booking[:movie_title]} \t#{booking[:time]}\t#{booking[:seat_number]}"
    end
    show_menu_cancel_ticket
  end

  def tickets_booking(movie_index, show_index)
    puts "\nEnter the number of tickets you want to book for this movie"
    tickets_number = gets.chomp.to_i

    movie = Movie.all_movies[movie_index]

    if (seat_number = movie.available_seats[show_index]) > 0 && movie.available_seats[show_index] >= tickets_number
      tickets_number.times do
        movie_time = movie.movie_timings[show_index]
        canceled_seat_numbers = CancelTicket.get_and_remove_cancel_tickets(movie.title, movie_time)
        seat_number = canceled_seat_numbers.first.to_i unless canceled_seat_numbers.empty?

        @@movies_bookings << { movie_title: movie.title, time: movie.movie_timings[show_index], seat_number: seat_number }
        puts "\e[32mTicket booked for #{movie.title}, #{movie_time}, Seat Number: #{seat_number}\e[0m"
        seat_number = movie.available_seats[show_index] -= 1
      end
      $flag = true
      main
    else
      display_error_message('Sorry, either the movie or the show timing is invalid, or no seats available for the chosen show')
      DisplayMovieInfo.show_available_seats(movie_index)
    end
  end
end

