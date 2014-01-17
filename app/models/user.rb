class User < ActiveRecord::Base
  attr_accessible :address1, :city, :country, :email, :name, :role, :telephoneNo
  include UsersHelper


  def welcome
    count_staff
    get_weather("kingston")
    get_mobay_weather
    #amount_staff_lost(@kgn_weather, "Kingston")
    amount_it_lost(@kgn_weather)

  end

  def self.get_weather(city)

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

def self.get_mobay_weather

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

 def self.amount_staff_lost(weather,city)
    @city = city
    @weekly = 0
    @total = 40
    @type = "Office"

    @mns = city

    weather.each do |w|
      if w == "Rain"
        @weekly += 4
      elsif w == "Sunny"
        @weekly += 8
      else
        @weekly += 8
      end
    end

  end

  def self.count_staff

    @kgn_IT_count = User.where("city = ? AND role = ?", "Kingston", "IT").size
    @mobay_IT_count = User.where("city = ? AND role = ?", "Montego Bay", "IT").size
    @kgn_office_count = User.where("city = ? AND role = ?", "Kingston", "Office").size
    @mobay_office_count = User.where("city = ? AND role = ?", "Montego Bay", "Office").size

    @kgn_count = @kgn_IT_count + @kgn_office_count
    @mobay_count = @mobay_office_count  + @mobay_IT_count

  end

  def self.weather

    #get weather forecast
    count_staff
    get_weather("kingston")
    get_mobay_weather

    #get respectively users
    @kgn_IT = User.where("city = ? AND role = ?", "Kingston", "IT")
    @mobay_IT = User.where("city = ? AND role = ?", "Montego Bay", "IT")
    @kgn_office = User.where("city = ? AND role = ?", "Kingston", "Office")
    @mobay_office = User.where("city = ? AND role = ?", "Montego Bay", "Office")

    #Kgn Push
    send_office_email(@kgn_weather, @kgn_office, "Kingston")
    send_it_email(@kgn_weather, @kgn_IT, "kgn" )

    #Mobay Push
    send_office_email(@mobay_weather, @mobay_office, "Montego Bay")
    send_it_email(@mobay_weather, @mobay_IT, "Mobay" )

  end



def self.check_rain(weather)
  if weather.include?("Rain")
    #@which_day = weather.each_index.select{|i| weather[i] == "Rain"}
  end
end

def self.send_office_email(weather,office_staff,city)

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

  office_staff.each do |emp|
    UserMailer.weather(emp, @weekly, city).deliver
  end

end

def self.send_it_email(weather, it_staff, city)

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



  def self.amount_it_lost(weather,city )
    @city = city
    @weekly = 0
    @total = 40
    @type = "IT"

    weather.each do |w|
      if w == "Rain"
        @weekly += 0
      elsif w == "Sunny"
        @weekly += 8
      else
        @weekly += 8
      end
    end

  end

end
