class AccountTransactionsController < ApplicationController
  before_action :set_account, only: %i[ index ]
  # GET /accounts or /accounts.json
  def index
    if @account.present?
      @transactions = @account.account_transactions
    else
      @transactions = AccountTransaction.all
    end
  end

  private

  def set_account
    @account = Account.find(params[:account_id]) if params[:account_id].present?
  end

end
