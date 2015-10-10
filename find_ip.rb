#!/usr/bin/env ruby
# parses a txt to find IP using grep
# can use geolocation to locate the IPs
# and print them in a txt file

puts 'Enter location of txt'
txt_location = gets.chomp

# the grep command to find the IP, is broken down into four parts
# each part is the parses for the 3 digits of the IP
# can be narrowed down with specific values
command_1 = 'grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
command_2 = '\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
command_3 = '\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
command_4 = '\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"'
command = (command_1 + command_2 + command_3 + command_4)

# generates the IPs list array
ip_list = `#{command} #{txt_location}`.split

ip_unique = []

# makes sure each IP appears only once
ip_list.each do |i|
  ip_unique.push(i) unless ip_unique.include?(i)
end

# prints the list with IPs
puts
puts ip_unique
puts

# starts the geolocation
# uses the site ipinfo.io for the requests
print 'Use geolocation? Y/n '
answer = gets.chomp

if answer == 'y' || answer == 'Y'

  time = Time.new
  time_now = time.strftime('%H.%M.%S')
  # creates a log file with a time stamp
  log = File.new('Desktop/ip_loc-' + time_now + '.log', 'w')

  # locates the IP and prints them in the log file
  ip_unique.each do |i|
    location = `curl ipinfo.io/#{i}`
    log.puts location
  end

  puts
  puts 'New log file created at ' + File.absolute_path(log)
end
