require_relative 'near_earth_objects'
require_relative 'table_formatter'

puts "________________________________________________________________________________________________________________________________"
puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
puts "Please enter a date in the following format YYYY-MM-DD."
print ">>"

date = gets.chomp
asteroid_details = NearEarthObjects.new(date).get_neos_by_date

total_number_of_asteroids = asteroid_details[:total_number_of_asteroids]
largest_asteroid = asteroid_details[:biggest_asteroid]

header = "| #{ TableFormatter.get_column_data(asteroid_details[:asteroid_list]).map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
divider = "+-#{ TableFormatter.get_column_data(asteroid_details[:asteroid_list]).map { |_,col| "-"*col[:width] }.join('-+-') }-+"

formatted_date = DateTime.parse(date).strftime("%A %b %d, %Y")
puts "______________________________________________________________________________"
puts "On #{formatted_date}, there were #{total_number_of_asteroids} objects that almost collided with the earth."
puts "The largest of these was #{largest_asteroid} ft. in diameter."
puts "\nHere is a list of objects with details:"
puts divider
puts header
TableFormatter.create_rows(asteroid_details[:asteroid_list])
puts divider
