class RemoveDateFromContacts < ActiveRecord::Migration[8.0]
  def change
    remove_column :contacts, :date, :string
  end
end
