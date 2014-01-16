class User < ActiveRecord::Base
  attr_accessible :address1, :city, :country, :email, :name, :role, :telephoneNo
  include UsersHelper

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

end
