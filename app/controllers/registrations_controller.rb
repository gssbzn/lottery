## Create subscriber registration
class RegistrationsController < ApplicationController

  def create
    @subscriber = Subscriber.find_or_create_by(registration_params)
    @registration = @subscriber.registrations.build(created_at: Date.today)
    
    if @subscriber.save
      @registration.reload
      unless @registration.prize.nil?
        flash[:success] = "You Won #{@registration.prize_name}"
      else
        flash[:notice] = 'Best Luck Next Time'
      end
    else
      error = @registration.errors[:subscriber].first.to_s unless @registration.errors[:subscriber].empty?
      error ||= 'Something went wrong'
      flash[:error] = error
    end    
    redirect_to :root
  end

  protected
  def registration_params
    params.require(:registration).permit(:email)
  end
end
