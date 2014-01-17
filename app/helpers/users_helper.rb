module UsersHelper

  def get_weather(city)
      #get 5 day forecast for Kingston
      require "open-uri"

      @link = "http://api.openweathermap.org/data/2.5/forecast/daily?q=#{city}&cnt=5&mode=json"
      @data = JSON.parse(JSON.load(open(@link)).to_json)

      @kgn_weather = []

      @data['list'].each do |d|
        d['weather'].each do |w|
          @kgn_weather << w['main']
        end
      end
  end

  def get_mobay_weather
    #get 5 day forecast for Mobay,  by city_id
      require "open-uri"

      @link = "http://api.openweathermap.org/data/2.5/forecast/daily?id=3489460&cnt=5&mode=json"
      @data = JSON.parse(JSON.load(open(@link)).to_json)

      @mobay_weather = []

      @data['list'].each do |d|
        d['weather'].each do |w|
          @mobay_weather << w['main']
        end
      end
  end


  def send_office_email(weather,office_staff,city)

    @weekly = []

    weather.each do |w|
      if w == "Rain"
        @weekly << "4 hours"
      else
        @weekly << "8 hours"
      end
    end

    office_staff.each do |emp|
      UserMailer.weather(emp, @weekly, city).deliver
    end

  end

  def send_it_email(weather, it_staff, city)

    @weekly = []

    weather.each do |w|
      if w == "Rain"
        @weekly << "Stay a yuh yard"
      else
        @weekly << "8 hours"
      end
    end

    it_staff.each do |it_emp|
      UserMailer.it_email(it_emp, @weekly, city).deliver
    end
  end

  def amount_staff_lost(weather,city)
    @city = city
    @weekly = 0
    @total = 40
    @type = "Office"

    weather.each do |w|
      if w == "Rain"
        @weekly += 4
      else
        @weekly += 8
      end
    end

  end

  def amount_it_lost(weather,city )
    @city = city
    @weekly = 0
    @total = 40
    @type = "IT"

    weather.each do |w|
      if w == "Rain"
        @weekly += 0
      else
        @weekly += 8
      end
    end

  end

  def count_staff

    @kgn_IT_count = User.where("city = ? AND role = ?", "Kingston", "IT").size
    @mobay_IT_count = User.where("city = ? AND role = ?", "Montego Bay", "IT").size
    @kgn_office_count = User.where("city = ? AND role = ?", "Kingston", "Office").size
    @mobay_office_count = User.where("city = ? AND role = ?", "Montego Bay", "Office").size

    @kgn_count = @kgn_IT_count + @kgn_office_count
    @mobay_count = @mobay_office_count  + @mobay_IT_count

  end


end
