class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.datetime :read_at
      t.integer :notifiable_id

      t.timestamps
    end
  end
end
