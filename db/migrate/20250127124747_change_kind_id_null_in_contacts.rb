class ChangeKindIdNullInContacts < ActiveRecord::Migration[8.0]
  def change
    change_column_null :contacts, :kind_id, false
  end
end
