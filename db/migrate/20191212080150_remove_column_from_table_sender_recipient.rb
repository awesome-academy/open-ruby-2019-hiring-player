class RemoveColumnFromTableSenderRecipient < ActiveRecord::Migration[6.0]
  def up
    remove_column :sender_recipients, :user_send
    remove_column :sender_recipients, :user_recieve
    remove_column :sender_recipients, :sender_recipient_id
    remove_column :sender_recipients, :sender_recipient_type
  end

  def down 
    add_column :sender_recipients, :user_send, :integer
    add_column :sender_recipients, :user_recieve, :integer
    add_column :sender_recipients, :sender_recipient_id, :integer
    add_column :sender_recipients, :sender_recipient_type, :string
  end
end
