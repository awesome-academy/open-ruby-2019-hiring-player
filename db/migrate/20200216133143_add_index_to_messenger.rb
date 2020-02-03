class AddIndexToMessenger < ActiveRecord::Migration[6.0]
  def change
    add_index :messengers, :created_at, order: :desc
  end
end
