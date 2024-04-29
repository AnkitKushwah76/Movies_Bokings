require_relative 'movie'
require_relative 'booking_system'
require_relative 'display_movies_info'
require_relative 'cancel_ticket'

$flag = false
# Adding movies
Movie.new("Pagalpanti", "comedy movie", ["10:00 AM", "11:00 PM", "12:00 PM"], 50)
Movie.new("Animal", "action movie", ["11:00 AM", "10:00 PM", "11:00 PM"], 40)

def show_menu_movies
  puts "\nEnter 1 to book tickets for a specific movie : "
  puts 'Enter 2 to go home page'
  puts 'Enter 3 to Exit'
  puts "Enter your choice: "
  choice = gets.chomp.to_i

  case choice

  when 1
    puts "Enter movie number which movie tickets you want to book: "
    movie_number = gets.chomp.to_i - 1
    DisplayMovieInfo.show_available_seats(movie_number)
  when 2
    main
  when 3
    puts "Exiting..."
    return
  else
    display_error_message('Invalid choice. Please enter a number between 1 to 3')
    display_all_movies
  end 
end

def show_menu
  puts "\nWelcome to Movie Ticket Booking System" 
  puts "\nEnter 1 to  Display available movies"
  puts 'Enter 2 to show your tickets' if $flag
  puts 'Enter 3 to Exit'
  puts "\nEnter your choice: "
end

def show_menu_cancel_ticket
  puts "\nEnter 1 to cancel for a specific ticket : "
  puts 'Enter 2 to go home page'

  choice = gets.chomp.to_i

  case choice
  when 1
    puts "\Enter the ticket number you want to cancel"
    ticket_number = gets.chomp.to_i
    CancelTicket.new.cancel_ticket(ticket_number)
  when 2  
    main
  else
    display_error_message('Invalid choice. Please enter a number between 1 and 2')
    show_menu_cancel_ticket
  end
end

def main
  show_menu
  choice = gets.chomp.to_i

  case choice
  when 1
    DisplayMovieInfo.display_all_movies
  when 2
    BookingSystem.show_tickets
  when 3
    puts "Exiting..."
    return
  else
    display_error_message('Invalid choice. Please enter a number between 1 and 2')
    main
  end
end

def display_error_message(message)
  puts "\e[31m#{message}\e[0m"
end

main