class GiftsController < ApplicationController
  def index
    @gifts = current_user.campaign.gifts if current_user
  end

  def create
     @gift = current_user.campaign.gifts.build(params[:gift])
    if @gift.save
      redirect_to @gift, :notice => "Successfully created gift."
    else
      render :action => 'new'
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    redirect_to gifts_url, :notice => "Successfully destroyed gift."
  end

  def show
    @gift = Gift.find(params[:id])
  end

  def edit
    @gift = Gift.find(params[:id])
  end

  def update
    @gift = Gift.find(params[:id])
    if @gift.update_attributes(params[:gift])
      redirect_to @gift, :notice  => "Successfully updated gift."
    else
      render :action => 'edit'
    end
  end

  def new
    @gift = current_user.campaign.gifts.build(params[:gift])
  end
end

