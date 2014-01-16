module UsersHelper

  def get_weather(city)

    require "open-uri"

    @link = "http://api.openweathermap.org/data/2.5/forecast/daily?q=Kingston&cnt=5&mode=json"
    @data = JSON.parse(JSON.load(open(@link)).to_json)

    @weather = []

    @data['list'].each do |d|
      d['weather'].each do |w|

        @weather << w['main']
      end
    end



  end
end
