class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.integer :money
      t.integer :status

      t.timestamps
    end
  end
end
