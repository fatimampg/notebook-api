class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :birthdate
      t.string :date

      t.timestamps
    end
  end
end
