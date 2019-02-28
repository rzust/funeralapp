class Reservation < ApplicationRecord

  validates :starting_time, presence: true, uniqueness: true

end
