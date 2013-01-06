class HomeController < ApplicationController
  def index
    @campaigns = Campaign.where(:active => true).paginate(page: params[:page], :per_page => 1)
  end

  def start
  end
end
