class TransactionsController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.source = User.where(name: params[:transaction][:source][:name]).first
      if @transaction.destination = User.where(name: params[:transaction][:destination][:name]).first
        @transaction.save!
        redirect_to users_path and return
      else
        flash[:error] = "Please enter valid Destination"
      end
    else
      flash[:error] = "Please enter valid Source"
    end
    render 'new'
  end

  private

    def transaction_params
      params.require(:transaction).permit(:amount)
    end
end