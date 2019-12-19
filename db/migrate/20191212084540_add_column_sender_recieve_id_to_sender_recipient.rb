class AddColumnSenderRecieveIdToSenderRecipient < ActiveRecord::Migration[6.0]
  def change
    add_reference :sender_recipients, :reactionable, polymorphic: true
    add_column :sender_recipients, :sender_id, :bigint
    add_column :sender_recipients, :receiver_id, :bigint
  end
end
