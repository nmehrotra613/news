require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

ForecastIO.api_key = "04baaef555b37f8dfdd3a836ef9b1826"

get "/" do
  view "ask"
end

get "/news" do
    results = Geocoder.search(params["location"])
    lat_lng = results.first.coordinates
    #I am pulling out the country's ISO code. This will allow me to get the national news for any country based on the location.
    # Per the News API documentation, some countries they don't support, so will result in no headlines.
    country_code = results.first.country_code
    @lat = lat_lng[0]
    @lng = lat_lng[1]
    @url = "https://newsapi.org/v2/top-headlines?country=" + country_code + "&apiKey=8e71709026c945cb9b81fe520447d246"
  view "news"
end