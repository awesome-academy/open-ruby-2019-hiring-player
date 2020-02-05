class UpdateSenderRecipients < ActiveRecord::Migration[6.0]
  def change
    add_column :sender_recipients, :checked, :boolean, default: false
  end
end
