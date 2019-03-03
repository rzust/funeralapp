class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  has_many :reservations

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email

  def to_s
    "#{first_name} #{last_name}"
  end

  class << self
    def send_reminders
      tomorrow = DateTime.now.beginning_of_day + 1.day
      Customer.includes(:reservations).all.each do |customer|
        reservations = customer.reservations.where(start_at: tomorrow..tomorrow.end_of_day).to_a
        CustomerMailer.reminder_email(customer, reservations).deliver_later if reservations.size > 0
      end
    end
  end
end
