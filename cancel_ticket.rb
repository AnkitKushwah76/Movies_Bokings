require_relative 'movie'

class CancelTicket
  @@cancel_tickets = []

  def self.get_and_remove_cancel_tickets(title, movie_time)
    canceled_seat_number = []
    @@cancel_tickets.reject! do |ticket|
      if ticket[:movie_title] == title && ticket[:time] == movie_time
        canceled_seat_number << ticket[:seat_number]
      end
    end

    canceled_seat_number
  end

  def cancel_ticket(ticket_number)  

    get_tickets = BookingSystem.get_booked_tickets
    booked_tickets = get_tickets[ticket_number - 1]

    unless booked_tickets
      display_error_message('Invalid ticket number Please enter a valid number')
      BookingSystem.show_tickets
      return
    end

    movie = Movie.all_movies.find { |m| m.title == booked_tickets[:movie_title] }

    movie_timing = movie.movie_timings.index(booked_tickets[:time])
    movie.available_seats[movie_timing] += 1
    get_tickets.delete_at(ticket_number-1)
    puts "\e[32mTicket canceled for #{movie.title}, #{movie.movie_timings[movie_timing]}, Seat Number: #{booked_tickets[:seat_number]}\e[0m"
    @@cancel_tickets << { movie_title: movie.title, time: movie.movie_timings[movie_timing], seat_number: booked_tickets[:seat_number] }
    main
  end
end