class ChangeColumnMessagesStatus < ActiveRecord::Migration[6.0]
  def change
    change_column_default :messages, :status, 'new'
  end
end
