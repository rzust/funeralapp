class Reservation < ApplicationRecord
  validates :start_at, presence: true, uniqueness: true
  belongs_to :customer

  def start_time
    self.start_at
  end
end
