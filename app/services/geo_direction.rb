# require 'json'
require 'httparty'
require 'json'
require 'net/http'
require 'active_support/core_ext/hash'

class GeoDirection
  include HTTParty

  BASE_URL = "https://maps.googleapis.com/maps/api/directions/json?"
  API_KEY = "&key=#{ENV["GOOGLE_API_KEY"]}"

  def self.get_routes origin:, destination:

    origin_path = "origin=" + origin.latitude.to_s + "," + origin.longitude.to_s
    destination_path = "&destination=" + destination.latitude.to_s + "," + destination.longitude.to_s
    alternate_routes = "&alternatives=true"
    request_url = BASE_URL + origin_path + destination_path + alternate_routes + API_KEY

    response = HTTParty.get(request_url)

    response["routes"].map do |direction_route|
      route = direction_route["legs"][0]
      {
       travel_distance: route["distance"]["value"],
       distance_unit: "meter",
       travel_time: route["duration"]["value"],
       time_unit: "seconds",
       origin_id: origin.id,
       destination_id: destination.id,
       travel_mode: "DRIVING"
      }
    end
  end
end