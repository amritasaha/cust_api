class UsersController < ApplicationController

  before_filter :authenticate_user_from_token! , :except => :index
  # This is Devise's authentication
  before_filter :authenticate_user! , :except => :index

  respond_to :json

  def index
    ## this method is accesible for all the user
  end

  def create
    ## this method will be accesible by only the logged in user
  end

end