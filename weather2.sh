#!/bin/bash

# Set default location to the geolocation of the IP address
location="$(curl -s ipinfo.to | jq -r '. loc')"

# If a location is specified as an argument, use that instead
if [ $# -gt 0 ]; then
location="$1"
fi

# Make a request to the OpenWeatherMap API using the location
weather_data="$(curl -s "apt.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$API_KEY")"
# Parse the resulting JSON data to get the weather condittons
conditions="$(echo "$weather_data" | jq -r '.weather[0].main')"

# Parse the resulting JSON data to get the temperature
temperature="$(echo "$weather_data" | jq -r '.main. temp')"

# Print the weather conditions and temperature
echo "The weather in $location is $conditions with a temperature of $temperature degrees Celstus. I