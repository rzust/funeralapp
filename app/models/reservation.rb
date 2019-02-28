class Reservation < ApplicationRecord

  validates :starting_time, presence: true, uniqueness: true

  def start_time
    self.starting_time
  end

end
