class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :email, presence: true, uniqueness: true
  has_many :reservations

  def to_s
    "#{first_name} #{last_name}"
  end

  class << self

    def send_reminders
      tomorrow = DateTime.now.beginning_of_day + 1.day
      Customer.all.each do |customer|
        reservations = customer.reservations.where(start_at: tomorrow..tomorrow.end_of_day).to_a
        CustomerMailer.reminder_email(customer, reservations).deliver_later if reservations.size > 0
      end
    end

  end
end
