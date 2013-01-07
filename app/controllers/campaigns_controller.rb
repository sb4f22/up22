class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new(params[:campaign])
    @campaign.user = current_user
  end

  def create
       @campaign = Campaign.new(params[:campaign])
       @campaign.user = current_user
    if @campaign.save
      redirect_to @campaign, :notice => "Successfully created campaign."
    else
      render :action => 'new'
    end
  end

  def show
    @campaign = Campaign.find_by_id(params[:id])
    @gifts = @campaign.gifts.paginate(:page => params[:page], :per_page => 1)
    unless signed_in?
      store_location
    end
    
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    redirect_to campaigns_url, :notice => "Successfully destroyed campaign."
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(params[:campaign])
      redirect_to @campaign, :notice  => "Successfully updated campaign."
    else
      render :action => 'edit'
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end 

  def activate
    @campaign = current_user.campaign
    @campaign.toggle!(:active)
    @campaign.end_date = 30.days.from_now
    @campaign.save
    if @campaign.update_attributes(params[:campaign])
      redirect_to @campaign, :notice  => "Campaign Activated. Good Luck!!"
    else
      redirect_to @campaign, :notice  => "Campaign Still Inactive."
    end
  end

  def deactivate
    @campaign = current_user.campaign
    @campaign.toggle!(:active)
    @campaign.end_date = nil
    @campaign.save
    if @campaign.update_attributes(params[:campaign])
      redirect_to @campaign, :notice  => "Campaign DeActivated"
    else
      redirect_to @campaign, :notice  => "Campaign Still Active."
    end
  end

   def store_location
    session[:return_to] = request.fullpath
  end

end
