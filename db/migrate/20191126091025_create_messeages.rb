class CreateMesseages < ActiveRecord::Migration[6.0]
  def change
    create_table :messeages do |t|
      t.string :messeage

      t.timestamps
    end
  end
end
