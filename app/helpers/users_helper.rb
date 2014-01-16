module UsersHelper

def get_weather(city)

    require "open-uri"

    @link = "http://api.openweathermap.org/data/2.5/forecast/daily?q=#{city}&cnt=5&mode=json"
    @data = JSON.parse(JSON.load(open(@link)).to_json)

    @weather = []

    @data['list'].each do |d|
      d['weather'].each do |w|
        @weather << w['main']
      end
    end
end

def check_rain(weather)
  if weather.include?("Rain")
    #@which_day = weather.index("Rain")
    @which_day = weather.each_index.select{|i| weather[i] == "Rain"}
  end
end

def send_email(which_day)
  #which_day.each do |day|

end

end
