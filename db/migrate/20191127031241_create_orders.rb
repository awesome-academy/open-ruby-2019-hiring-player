class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.datetime :time_start
      t.datetime :time_end
      t.integer :hourly_rent
      t.integer :status

      t.timestamps
    end
  end
end
