class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def start
  end

  
end
