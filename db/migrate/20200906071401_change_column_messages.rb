class ChangeColumnMessages < ActiveRecord::Migration[6.0]
  def change
    change_column_null :messages, :staff_member_id, true
  end
end
