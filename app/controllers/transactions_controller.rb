class TransactionsController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.source = User.where(email: params[:transaction][:source][:email]).first
    @transaction.destination = current_user

    if @transaction.save
      flash[:notice] = "Successfully trasferred"
      redirect_to users_path
    else
      flash[:error] = @transaction.errors.full_messages.to_sentence
      render :new
    end
  end

  private

    def transaction_params
      params.require(:transaction).permit(:amount)
    end
end