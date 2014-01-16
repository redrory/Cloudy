class UsersController < ApplicationController
  include UsersHelper

  def index
  end

  def new
    @user = User.new
    @cities = City.all
    @roles = Role.all
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html {redirect_to(@user,
                                :notice => 'User was successfully create.')}
        format.json {render :json => @user,
                                :status => :created, :location => @user}

      else
        format.html {render :action => "new"}
        format.json {render :json => @user.errors,
                      :status => :unprocessable_entity}
      end
    end
  end

  def welcome
    count_staff
    get_weather("kingston")
    get_mobay_weather
    amount_staff_lost(@kgn_weather, "Kingston")
    #amount_it_lost(@kgn_weather)

  end

  def weather

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


  def show
    @user = User.find(params[:id])

  end
end
