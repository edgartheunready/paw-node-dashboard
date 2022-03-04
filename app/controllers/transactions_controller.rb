class TransactionsController < ApplicationController
  before_action :set_tribe, only: %i[ index ]
  # GET /tribes or /tribes.json
  def index
    if @tribe.present?
      @transactions = @tribe.transactions
    else
      @transactions = Transaction.all
    end
  end

  private

  def set_tribe
    @tribe = Tribe.find(params[:tribe_id]) if params[:tribe_id].present?
  end

end
