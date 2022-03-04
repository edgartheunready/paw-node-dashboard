class TransactionsController < ApplicationController
  before_action :set_tribe, only: %i[ index ]
  # GET /tribes or /tribes.json
  def index
    @transactions = @tribe.transactions
  end

  private

  def set_tribe
    @tribe = Tribe.find(params[:tribe_id])
  end

end
