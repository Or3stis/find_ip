#!/usr/bin/env ruby
# refarctored find_ip.rb
# uses methods

def prompt(arg)
  puts(arg)
  gets.chomp
end

def grep
  # the grep command to find the IP, is broken down into four parts
  # each part is the parses for the 3 digits of the IP
  # can be narrowed down with specific values
  command_1 = 'grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
  command_2 = '\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
  command_3 = '\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
  command_4 = '\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" '
  command_1 + command_2 + command_3 + command_4
end

def find_ip(txt_location)
  # run the grep to generate the ip list
  ip_list = `#{grep} #{txt_location}`.split

  # creates a new list with only unique IP
  ip_unique = []

  ip_list.each do |i|
    ip_unique.push(i) unless ip_unique.include?(i)
  end

  # return value of the function
  ip_unique
end

def geolocation(txt_location)
  # uses the geolocation with curl as the command
  # and the site ipinfo.io
  time = Time.new
  time_now = time.strftime('%H.%M.%S')
  # creates a log file with a time stamp
  log = File.new('Desktop/ip_loc-' + time_now + '.log', 'w')

  # locates the IP and prints them in the log file
  find_ip(txt_location).each do |i|
    location = `curl ipinfo.io/#{i}`
    log.puts location
  end

  puts "\nNew log file created at " + File.absolute_path(log)
end

def user_input
  # function used by the user to enter data
  txt_location = prompt('Enter location of txt: ')
  puts find_ip(txt_location)
  choice = prompt('Use geolocation? Y/n: ')
  geolocation(txt_location) if choice == 'y' || choice == 'Y'
end

user_input
