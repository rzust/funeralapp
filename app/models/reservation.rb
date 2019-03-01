class Reservation < ApplicationRecord

  validates :starting_time, presence: true, uniqueness: true
  belongs_to :customer

  def start_time
    self.starting_time
  end

end
