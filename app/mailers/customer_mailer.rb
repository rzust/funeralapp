class CustomerMailer < ApplicationMailer
  def reminder_email(customer, reservations)
    @name = customer.to_s
    @reservations = reservations
    mail(to: customer.email, subject: 'You have a reservation tomorrow!')
  end
end
