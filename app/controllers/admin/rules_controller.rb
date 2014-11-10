## Manage Rules
class Admin::RulesController < ApplicationController
  before_filter :authenticate_admin!
  
  #before_action :set_rule, only: [:show, :edit, :update, :destroy]
  before_action :set_rule_prize, only: [:show, :edit, :update, :destroy]
  before_action :set_prize, only: [:new, :create]
  
  # GET /prizes/1/rule/1
  # GET /prizes/1/rule/1.json
  def show
  end

  # GET /prizes/1/rule/new
  def new
    @rule = Rule.new
  end

  # GET /prizes/1/edit
  def edit
  end

  # POST /prizes/1/rule/
  # POST /prizes/1/rule/.json
  def create
    @rule = Rule.new(rule_params)
    @rule.prize = @prize
    respond_to do |format|
      if @rule.save
        format.html { redirect_to admin_prize_path(@prize), notice: t(:created, scope:'actioncontroller.rule') }
        format.json { render action: 'show', status: :created, location: @rule }
      else
        format.html { render action: 'new' }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prizes/1/rule/1
  # PATCH/PUT /prizes/1/rule/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to admin_prize_rule_path(@prize, @rule), notice: t(:updated, scope:'actioncontroller.rule') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prizes/1/rule/1
  # DELETE /prizes/1/rule/1.json
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to admin_prize_url }
      format.json { head :no_content }
    end
  end

  protected
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.includes(:prize).find(params[:id])
    end
    
    def set_prize
      @prize = Prize.find(params[:prize_id])
    end
    
    def set_rule_prize
      set_rule
      @prize = @rule.prize
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rule_params
      params.require(:rule).permit(:name, :participant_number, :participant_number_multiple, :participant_number_after)
    end
end
