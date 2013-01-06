class TransactionsController < ApplicationController
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
    @transaction.save!
    if @transaction.save
      if @transaction.gift_id.present?
        @gift_id = @transaction.gift_id
        @gift = Gift.find_by_id(@gift_id)
        @gift_count = @gift.stock - 1
        @gift.update_attributes(:stock => @gift_count)
      end
      redirect_to @transaction, :notice => "Transaction Complete. Thank You!" 
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
end
