class ReservationsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_reservations, only: [:index]
  respond_to :html

  def new
    @selected_day = DateTime.parse(params[:selected_day])
    reservations = Reservation.where(start_at: @selected_day.beginning_of_day..@selected_day.end_of_day)
    @taken_slots = reservations.map{|x| x.start_at.hour}
  end

  def create
    reservation    = current_customer.reservations.build(reservation_params)
    reservation.end_at = reservation.start_at + 2.hours
    flash[:notice] = "Reservation successfully created!" if reservation.save
    redirect_to action: "index"
  end

  private

  def set_reservations
    start_date = params[:start_date].present? ? DateTime.parse(params[:start_date]) : DateTime.now
    @reservations = Reservation.where(start_at: (start_date.beginning_of_month - 6.days)..(start_date.end_of_month + 7.days).end_of_day)
  end

  def reservation_params
    params.require(:reservation).permit(:start_at)
  end
end
