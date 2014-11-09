class RegistrationsController < ApplicationController

  def create
    @subscriber = Subscriber.find_or_create_by(registration_params)
    @registration = @subscriber.registrations.build(created_at: Date.today)

    flash = {notice: ':)'} if @subscriber.save
    puts @subscriber.errors.to_h.to_s
    flash = {error: @subscriber.errors} unless @subscriber.valid?
    redirect_to :root, flash
  end

  protected
  def registration_params
    params.require(:registration).permit(:email)
  end
end
