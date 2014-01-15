class User < ActiveRecord::Base
  attr_accessible :address1, :city, :country, :email, :name, :role, :telephoneNo
end
