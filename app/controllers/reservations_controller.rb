class ReservationsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_reservations, only: [:index]
  respond_to :html

  def new
    @selected_day = DateTime.parse(params[:selected_day])
    reservations = Reservation.where(starting_time: @selected_day.beginning_of_day..@selected_day.end_of_day)
    @taken_slots = reservations.map{|x| x.starting_time.hour}
  end

  def create
    reservation    = Reservation.new(reservation_params)
    reservation.end_time = reservation.starting_time + 2.hours
    flash[:notice] = "Reservation successfully created!" if reservation.save
    redirect_to action: "index"
  end

private
  def set_reservations
    start_date = params[:start_date].present? ? DateTime.parse(params[:start_date]) : DateTime.now
    @reservations = Reservation.where(starting_time: start_date.beginning_of_day..(start_date+34.days).end_of_day)
  end

  def reservation_params
    params.require(:reservation).permit(:starting_time)
  end
end
