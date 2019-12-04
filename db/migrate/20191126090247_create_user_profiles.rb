class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string :address
      t.integer :age
      t.integer :gender
      t.integer :money
      t.string :game
      t.string :rank
      t.integer :hourly_rent
      t.string :avatar

      t.timestamps
    end
  end
end
