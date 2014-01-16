class UsersController < ApplicationController
  include UsersHelper

  def index
  end

  def new
    @user = User.new
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
  end

  def weather
    get_weather("kingston")

    get_mobay_weather

    #@kgn_employees = User.find_all_by_city("Kingston")
    #@mobay_employees = User.find_all_by_city("Montego Bay")

    @kgn_IT = User.where("city = ? AND role = ?", "Kingston", "IT")
    @mobay_IT = User.where("city = ? AND role = ?", "Montego Bay", "IT")
    @kgn_office = User.where("city = ? AND role = ?", "Kingston", "Office")
    @mobay_office = User.where("city = ? AND role = ?", "Montego Bay", "Office")

    @user = @kgn_IT.first

    check_rain(@kgn_weather)
    send_office_email(@kgn_weather)
    send_it_email(@kgn_weather)

    #UserMailer.weather(@user, @weekly).deliver

  end


  def show
    @user = User.find(params[:id])

  end
end
