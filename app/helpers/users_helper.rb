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
    #@which_day = weather.each_index.select{|i| weather[i] == "Rain"}
  end
end

def send_office_email(weather)

  @weekly = []

  weather.each do |w|
    if w == "Rain"
      @weekly << "4 hours"
    elsif w == "Sunny"
      @weekly << "8 hours"
    else
      @weekly << "8 hours"
    end
  end

end

def send_it_email(weather)

  @weekly = []

  weather.each do |w|
    if w == "Rain"
      @weekly << "Stay a yuh yard"
    else
      @weekly << "8 hours"
    end
  end

end

end
