class UpdateModelOrder < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :time_start
    remove_column :orders, :time_end
    remove_column :orders, :hourly_rent
    change_column :orders, :status, :integer, default: 0
    add_column :orders, :cost, :integer
    add_column :orders, :rental_period, :integer
  end
end
