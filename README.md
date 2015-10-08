# find_ip
IP parcer and geolocator using ruby and system commands. No external library needed.

Simple script that parces the IP addresses from a text file.

It has the option of using geolocation to find the geographical location of the IP and ouput them in a text file in the Desktop.

Uses grep to parce the IPs and curl to make the requests for geolocation.

Only works in Linux and Mac.

# Usage
    ruby find_ip.rb

Then enter the path of the txt file with the IPs.

