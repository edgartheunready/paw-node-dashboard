class TribesController < ApplicationController
  before_action :set_tribe, only: %i[ show edit update destroy ]

  # GET /tribes or /tribes.json
  def index
    @tribes = Tribe.all
  end

  # GET /tribes/1 or /tribes/1.json
  def show
    @transactions = @tribe.transactions.order("local_timestamp desc")
  end

  # GET /tribes/new
  def new
    @tribe = Tribe.new
  end

  # GET /tribes/1/edit
  def edit
  end

  # POST /tribes or /tribes.json
  def create
    @tribe = Tribe.new(tribe_params)

    respond_to do |format|
      if @tribe.save
        format.html { redirect_to tribe_url(@tribe), notice: "Tribe was successfully created." }
        format.json { render :show, status: :created, location: @tribe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tribe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tribes/1 or /tribes/1.json
  def update
    respond_to do |format|
      if @tribe.update(tribe_params)
        format.html { redirect_to tribe_url(@tribe), notice: "Tribe was successfully updated." }
        format.json { render :show, status: :ok, location: @tribe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tribe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tribes/1 or /tribes/1.json
  def destroy
    @tribe.destroy

    respond_to do |format|
      format.html { redirect_to tribes_url, notice: "Tribe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tribe
      @tribe = Tribe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tribe_params
      params.require(:tribe).permit(:name, :uuid)
    end
end
