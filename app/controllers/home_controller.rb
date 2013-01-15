class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @campaigns = Campaign.where(:active => true).paginate(page: params[:page], :per_page => 1)
  end

  def start
  end

  def presentation
    @campaigns = Campaign.where(:active => true).paginate(page: params[:page], :per_page => 1)
  end

end
