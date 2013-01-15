class TransactionsController < ApplicationController

include WepayRails::Payments

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
    @funder = User.find_by_id(@transaction.funder_id)
    @funded = User.find_by_id(@transaction.funded_id)
    @gift = Gift.find_by_id(@transaction.gift_id)
  end

  def new
    @transaction = current_user.transactions.build(params[:transaction])
  end

  def create
    @transaction = current_user.transactions.build(params[:transaction])
    @app_fee = (@transaction.amount)*(0.07)
    wepay_gateway = WepayRails::Payments::Gateway.new(@transaction.funded.wepay_token)
    response = wepay_gateway.perform_checkout({
        :account_id         => @transaction.funded.wepay_account_id,
        :amount             => @transaction.amount,
        :app_fee            => @app_fee,
        :short_description  => @transaction.description,
        :redirect_uri       => 'http://tranquil-everglades-6746.herokuapp.com/confirm',
        :type               => 'GOODS'
        })
      @transaction.checkout_id = response[:checkout_id]
      @transaction.checkout_uri = response[:checkout_uri]

     @transaction.save!
     if @transaction.save
        if 
          @transaction.gift_id.present?
          @gift_id = @transaction.gift_id
          @gift = Gift.find_by_id(@gift_id)
          @gift_count = @gift.stock - 1
          @gift.update_attributes(:stock => @gift_count)
        end
        redirect_to @transaction.checkout_uri
    else
      render :action => 'new'
    end
  end


  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update_attributes(params[:transaction])
      redirect_to @transaction, :notice  => "Successfully updated transaction."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to transactions_url, :notice => "Successfully destroyed transaction."
  end

  def confirmation
    @transaction  = Transaction.find_by_checkout_id(params[:checkout_id])
    @gift  = Gift.find_by_id(params[:gift_id])
  end

end
