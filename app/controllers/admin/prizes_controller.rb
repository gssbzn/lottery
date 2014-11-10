class Admin::PrizesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_prize, only: [:show, :edit, :update, :destroy]

  # GET /prizes
  # GET /prizes.json
  def index
    @prizes = Prize.all
  end

  # GET /prizes/1
  # GET /prizes/1.json
  def show
  end

  # GET /prizes/new
  def new
    @prize = Prize.new
  end

  # GET /prizes/1/edit
  def edit
    @prize.qty_available = @prize.inventory.qty_available
  end

  # POST /prizes
  # POST /prizes.json
  def create
    @prize = Prize.new(prize_params)
    @prize.build_inventory(qty_available: @prize.qty_available)
    respond_to do |format|
      if @prize.save
        format.html { redirect_to admin_prize_path(@prize), notice: t(:created, scope:'actioncontroller.prize') }
        format.json { render action: 'show', status: :created, location: @prize }
      else
        format.html { render action: 'new' }
        format.json { render json: @prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prizes/1
  # PATCH/PUT /prizes/1.json
  def update
    respond_to do |format|
      if @prize.update(prize_params) && @prize.inventory.update(qty_available: @prize.qty_available)
        format.html { redirect_to admin_prize_path(@prize), notice: t(:updated, scope:'actioncontroller.prize') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prizes/1
  # DELETE /prizes/1.json
  def destroy
    @prize.destroy
    respond_to do |format|
      format.html { redirect_to admin_prizes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prize
      @prize = Prize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prize_params
      params.require(:prize).permit(:name, :qty_available)
    end
end
