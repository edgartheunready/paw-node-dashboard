class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @accounts.to_json }
    end
  end

  # GET /accounts/1 or /accounts/1.json
  def show
    @transactions = @account.account_transactions.order("created_at desc")
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to account_url(@account), notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to account_url(@account), notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def trends
    if AccountTransaction.last.to_datetime < 10.minutes.ago
      Account.scrape_all
    end
    @trends = Account.generate_trends
    @payouts = Account.generate_payouts

    totals = @trends.map(&:clone)
    totals.shift
    @trends << ["Totals"] + totals.map{|it| it.shift; it}.transpose.map{|it| it.sum}
    
    totals = @payouts.map(&:clone)
    totals.shift
    @payouts << ["Totals"] + totals.map{|it| it.shift; it}.transpose.map{|it| it.sum}
    
    @countdown = AccountTransaction.payouts.where(created_at: (DateTime.parse("2022-03-12T20:26:41-05:00")..0.days.ago)).map{|it| it.normalized_amount.to_f}.sum.to_i
    @counts = AccountTransaction.payouts.where(created_at:72.hours.ago..0.days.ago).group(:account_id).count.invert
    @counts = @counts.keys.sort.map{|it| @counts[it]}.reverse << "total"
    @hourly = AccountTransaction.hourly_by_account()
    @hourly_paw = AccountTransaction.hourly_paw_by_account()
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :uuid)
    end
end
