class HomeController < ApplicationController
  before_filter :authenticate_user_from_token!, :except => :index
  before_filter :authenticate_user!, :except => :index


  def index

  end

end
