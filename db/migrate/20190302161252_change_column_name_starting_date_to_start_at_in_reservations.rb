class ChangeColumnNameStartingDateToStartAtInReservations < ActiveRecord::Migration[5.2]
  def change
    rename_column :reservations, :starting_time, :start_at
    rename_column :reservations, :end_time, :end_at
  end
end
