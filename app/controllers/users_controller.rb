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
    get_weather("negril")
    @kgn_employees = User.find_all_by_city("Kingston")
    @user = @kgn_employees.first

    check_rain(@weather)
    send_office_email(@weather)

    #UserMailer.weather(@user, @weekly).deliver
    @mobay_employees = User.find_all_by_city("Montego Bay")
  end


  def show
    @user = User.find(params[:id])

  end
end
