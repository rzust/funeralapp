class ReservationsController < ApplicationController
  before_action :authenticate_customer!
  respond_to :html

  def new
    @selected_day = DateTime.parse(params[:selected_day])
    reservations = Reservation.where(starting_time: @selected_day.beginning_of_day..@selected_day.end_of_day)
    @reservations = reservations.map{|x| x.starting_time.hour}
  end

  def create
    reservation    = Reservation.new(reservation_params)
    reservation.end_time = reservation.starting_time + 2.hours
    flash[:notice] = "Reservation successfully created!" if reservation.save
    render :index
  end

  def reservation_params
    params.require(:reservation).permit(:starting_time)
  end
end
