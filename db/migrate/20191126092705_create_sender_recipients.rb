class CreateSenderRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :sender_recipients do |t|
      t.integer :user_send
      t.integer :user_recieve
      t.integer :sender_recipient_id
      t.string :sender_recipient_type

      t.timestamps
    end
  end
end
